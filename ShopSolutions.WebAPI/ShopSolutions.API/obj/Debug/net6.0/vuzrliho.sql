IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [AppConfig] (
    [Id] int NOT NULL IDENTITY,
    [Key] nvarchar(max) NOT NULL,
    [Value] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_AppConfig] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [Category] (
    [Id] int NOT NULL IDENTITY,
    [SortOrder] int NOT NULL,
    [IsShowOnHome] bit NOT NULL,
    [ParentId] int NULL,
    [Status] int NOT NULL,
    CONSTRAINT [PK_Category] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [Contact] (
    [Id] int NOT NULL IDENTITY,
    [Name] nvarchar(max) NOT NULL,
    [Email] nvarchar(max) NOT NULL,
    [PhoneNumber] nvarchar(max) NOT NULL,
    [Message] nvarchar(max) NOT NULL,
    [Status] int NOT NULL,
    CONSTRAINT [PK_Contact] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [Language] (
    [Id] nvarchar(450) NOT NULL,
    [Name] nvarchar(max) NOT NULL,
    [IsDefault] bit NOT NULL,
    CONSTRAINT [PK_Language] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [Product] (
    [Id] int NOT NULL IDENTITY,
    [Price] decimal(18,2) NOT NULL,
    [CriginaPrice] decimal(18,2) NOT NULL,
    [Stock] int NOT NULL,
    [ViewCount] int NOT NULL,
    [DateCreated] datetime2 NOT NULL,
    [SeoAlias] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_Product] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [Promotion] (
    [Id] int NOT NULL IDENTITY,
    [FromDate] datetime2 NOT NULL,
    [ToDate] datetime2 NOT NULL,
    [ApplyForAll] bit NOT NULL,
    [DiscountPercent] int NULL,
    [DiscountAmount] decimal(18,2) NULL,
    [ProductIds] nvarchar(max) NOT NULL,
    [ProductCategoryIds] nvarchar(max) NOT NULL,
    [Status] int NOT NULL,
    [Name] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_Promotion] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [Role] (
    [Id] uniqueidentifier NOT NULL,
    [Name] nvarchar(256) NULL,
    [NormalizedName] nvarchar(256) NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    CONSTRAINT [PK_Role] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [User] (
    [Id] uniqueidentifier NOT NULL,
    [FirstName] nvarchar(max) NOT NULL,
    [LastName] nvarchar(max) NOT NULL,
    [DateOfBirth] datetime2 NOT NULL,
    [UserName] nvarchar(256) NULL,
    [NormalizedUserName] nvarchar(256) NULL,
    [Email] nvarchar(256) NULL,
    [NormalizedEmail] nvarchar(256) NULL,
    [EmailConfirmed] bit NOT NULL,
    [PasswordHash] nvarchar(max) NULL,
    [SecurityStamp] nvarchar(max) NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    [PhoneNumber] nvarchar(max) NULL,
    [PhoneNumberConfirmed] bit NOT NULL,
    [TwoFactorEnabled] bit NOT NULL,
    [LockoutEnd] datetimeoffset NULL,
    [LockoutEnabled] bit NOT NULL,
    [AccessFailedCount] int NOT NULL,
    CONSTRAINT [PK_User] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [CategoryTranslation] (
    [Id] int NOT NULL IDENTITY,
    [CategoryId] int NOT NULL,
    [Name] nvarchar(max) NOT NULL,
    [SeoDescription] nvarchar(max) NOT NULL,
    [SeoTitle] nvarchar(max) NOT NULL,
    [LanguageId] nvarchar(450) NOT NULL,
    [SeoAlias] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_CategoryTranslation] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_CategoryTranslation_Category_CategoryId] FOREIGN KEY ([CategoryId]) REFERENCES [Category] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_CategoryTranslation_Language_LanguageId] FOREIGN KEY ([LanguageId]) REFERENCES [Language] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [ProductInCategory] (
    [Id] int NOT NULL IDENTITY,
    [ProductId] int NOT NULL,
    [CategoryId] int NOT NULL,
    CONSTRAINT [PK_ProductInCategory] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ProductInCategory_Category_CategoryId] FOREIGN KEY ([CategoryId]) REFERENCES [Category] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_ProductInCategory_Product_ProductId] FOREIGN KEY ([ProductId]) REFERENCES [Product] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [ProductTranslation] (
    [Id] int NOT NULL IDENTITY,
    [ProductId] int NOT NULL,
    [Name] nvarchar(max) NOT NULL,
    [Description] nvarchar(max) NOT NULL,
    [Details] nvarchar(max) NOT NULL,
    [SeoDescription] nvarchar(max) NOT NULL,
    [SeoTitle] nvarchar(max) NOT NULL,
    [SeoAlias] nvarchar(max) NOT NULL,
    [LanguageId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_ProductTranslation] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ProductTranslation_Language_LanguageId] FOREIGN KEY ([LanguageId]) REFERENCES [Language] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_ProductTranslation_Product_ProductId] FOREIGN KEY ([ProductId]) REFERENCES [Product] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [Role_Claim] (
    [Id] int NOT NULL IDENTITY,
    [RoleId] uniqueidentifier NOT NULL,
    [ClaimType] nvarchar(max) NULL,
    [ClaimValue] nvarchar(max) NULL,
    CONSTRAINT [PK_Role_Claim] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Role_Claim_Role_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [Role] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [Cart] (
    [Id] int NOT NULL IDENTITY,
    [ProductId] int NOT NULL,
    [Quantity] int NOT NULL,
    [Price] decimal(18,2) NOT NULL,
    [UserId] uniqueidentifier NOT NULL,
    [DateCreated] datetime2 NOT NULL,
    [AppUserId] uniqueidentifier NULL,
    CONSTRAINT [PK_Cart] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Cart_Product_ProductId] FOREIGN KEY ([ProductId]) REFERENCES [Product] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_Cart_User_AppUserId] FOREIGN KEY ([AppUserId]) REFERENCES [User] ([Id])
);
GO

CREATE TABLE [Order] (
    [Id] int NOT NULL IDENTITY,
    [OrderDate] datetime2 NOT NULL,
    [UserId] uniqueidentifier NOT NULL,
    [ShipName] nvarchar(max) NOT NULL,
    [ShipAddress] nvarchar(max) NOT NULL,
    [ShipEmail] nvarchar(max) NOT NULL,
    [ShipPhoneNumber] nvarchar(max) NOT NULL,
    [Status] int NOT NULL,
    [AppUserId] uniqueidentifier NULL,
    CONSTRAINT [PK_Order] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Order_User_AppUserId] FOREIGN KEY ([AppUserId]) REFERENCES [User] ([Id])
);
GO

CREATE TABLE [Transaction] (
    [Id] int NOT NULL IDENTITY,
    [TransactionDate] datetime2 NOT NULL,
    [ExternalTransactionId] nvarchar(max) NOT NULL,
    [Amount] decimal(18,2) NOT NULL,
    [Fee] decimal(18,2) NOT NULL,
    [Result] nvarchar(max) NOT NULL,
    [Message] nvarchar(max) NOT NULL,
    [Status] int NOT NULL,
    [Provider] nvarchar(max) NOT NULL,
    [AppUserId] uniqueidentifier NULL,
    CONSTRAINT [PK_Transaction] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Transaction_User_AppUserId] FOREIGN KEY ([AppUserId]) REFERENCES [User] ([Id])
);
GO

CREATE TABLE [User_Claim] (
    [Id] int NOT NULL IDENTITY,
    [UserId] uniqueidentifier NOT NULL,
    [ClaimType] nvarchar(max) NULL,
    [ClaimValue] nvarchar(max) NULL,
    CONSTRAINT [PK_User_Claim] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_User_Claim_User_UserId] FOREIGN KEY ([UserId]) REFERENCES [User] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [User_Login] (
    [UserId] uniqueidentifier NOT NULL,
    [LoginProvider] nvarchar(max) NULL,
    [ProviderKey] nvarchar(max) NULL,
    [ProviderDisplayName] nvarchar(max) NULL,
    CONSTRAINT [PK_User_Login] PRIMARY KEY ([UserId]),
    CONSTRAINT [FK_User_Login_User_UserId] FOREIGN KEY ([UserId]) REFERENCES [User] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [User_Role] (
    [UserId] uniqueidentifier NOT NULL,
    [RoleId] uniqueidentifier NOT NULL,
    CONSTRAINT [PK_User_Role] PRIMARY KEY ([UserId], [RoleId]),
    CONSTRAINT [FK_User_Role_Role_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [Role] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_User_Role_User_UserId] FOREIGN KEY ([UserId]) REFERENCES [User] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [User_Token] (
    [UserId] uniqueidentifier NOT NULL,
    [LoginProvider] nvarchar(450) NOT NULL,
    [Name] nvarchar(450) NOT NULL,
    [Value] nvarchar(max) NULL,
    CONSTRAINT [PK_User_Token] PRIMARY KEY ([UserId], [LoginProvider], [Name]),
    CONSTRAINT [FK_User_Token_User_UserId] FOREIGN KEY ([UserId]) REFERENCES [User] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [OrderDetail] (
    [Id] int NOT NULL IDENTITY,
    [OrderId] int NOT NULL,
    [ProductId] int NOT NULL,
    [Quantity] int NOT NULL,
    [Price] decimal(18,2) NOT NULL,
    CONSTRAINT [PK_OrderDetail] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_OrderDetail_Order_OrderId] FOREIGN KEY ([OrderId]) REFERENCES [Order] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_OrderDetail_Product_ProductId] FOREIGN KEY ([ProductId]) REFERENCES [Product] ([Id]) ON DELETE CASCADE
);
GO

CREATE INDEX [IX_Cart_AppUserId] ON [Cart] ([AppUserId]);
GO

CREATE INDEX [IX_Cart_ProductId] ON [Cart] ([ProductId]);
GO

CREATE INDEX [IX_CategoryTranslation_CategoryId] ON [CategoryTranslation] ([CategoryId]);
GO

CREATE INDEX [IX_CategoryTranslation_LanguageId] ON [CategoryTranslation] ([LanguageId]);
GO

CREATE INDEX [IX_Order_AppUserId] ON [Order] ([AppUserId]);
GO

CREATE INDEX [IX_OrderDetail_OrderId] ON [OrderDetail] ([OrderId]);
GO

CREATE INDEX [IX_OrderDetail_ProductId] ON [OrderDetail] ([ProductId]);
GO

CREATE INDEX [IX_ProductInCategory_CategoryId] ON [ProductInCategory] ([CategoryId]);
GO

CREATE INDEX [IX_ProductInCategory_ProductId] ON [ProductInCategory] ([ProductId]);
GO

CREATE INDEX [IX_ProductTranslation_LanguageId] ON [ProductTranslation] ([LanguageId]);
GO

CREATE INDEX [IX_ProductTranslation_ProductId] ON [ProductTranslation] ([ProductId]);
GO

CREATE UNIQUE INDEX [RoleNameIndex] ON [Role] ([NormalizedName]) WHERE [NormalizedName] IS NOT NULL;
GO

CREATE INDEX [IX_Role_Claim_RoleId] ON [Role_Claim] ([RoleId]);
GO

CREATE INDEX [IX_Transaction_AppUserId] ON [Transaction] ([AppUserId]);
GO

CREATE INDEX [EmailIndex] ON [User] ([NormalizedEmail]);
GO

CREATE UNIQUE INDEX [UserNameIndex] ON [User] ([NormalizedUserName]) WHERE [NormalizedUserName] IS NOT NULL;
GO

CREATE INDEX [IX_User_Claim_UserId] ON [User_Claim] ([UserId]);
GO

CREATE INDEX [IX_User_Role_RoleId] ON [User_Role] ([RoleId]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20230917104835_NewdatabaseShopSolution', N'6.0.0');
GO

COMMIT;
GO

