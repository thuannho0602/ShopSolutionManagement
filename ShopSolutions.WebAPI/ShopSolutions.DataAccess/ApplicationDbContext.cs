using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using ShopSolutions.Entity;

namespace ShopSolutions.DataAccess
{
    public class ApplicationDbContext : IdentityDbContext<AppUser, IdentityRole<Guid>, Guid>
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        {

        }
        public virtual DbSet<AppConfig> AppConfigs { get; set; }
        public virtual DbSet<Product> Products { get; set; }
        public virtual DbSet<Category> Categories { get; set; }
        public virtual DbSet<Cart> Carts { get; set; }
        public virtual DbSet<CategoryTranslation> CategoryTranslations { get; set; }
        public virtual DbSet<Contact> Contacts { get; set; }
        public virtual DbSet<Language> Languages { get; set; }
        public virtual DbSet<Order> Orders { get; set; }
        public virtual DbSet<OrderDetail> OrderDetails { get; set; }
        public virtual DbSet<ProductInCategory> ProductInCategories { get; set; }
        public virtual DbSet<ProductTranslation> ProductTranslations { get; set; }
        public virtual DbSet<Promotion> Promotions { get; set; }
        public virtual DbSet<Transaction> Transactions { get; set; }
        public virtual DbSet<AppUser> AppUsers { get; set; }
        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);
            builder.Entity<AppUser>(entity => { entity.ToTable(name: "User"); });

            #region Identity config
            builder.Entity<IdentityRole<Guid>>()
                .ToTable("Role");

            builder.Entity<IdentityUserRole<Guid>>()
                .ToTable("User_Role")
                .HasKey(x => new { x.UserId, x.RoleId });

            builder.Entity<IdentityUserClaim<Guid>>()
                .ToTable("User_Claim")
                .HasKey(x => x.Id);

            builder.Entity<IdentityUserLogin<Guid>>()
                .ToTable("User_Login")
                .HasKey(x => x.UserId);

            builder.Entity<IdentityUserToken<Guid>>()
                .ToTable("User_Token")
                .HasKey(x => new { x.UserId, x.LoginProvider, x.Name });

            builder.Entity<IdentityRoleClaim<Guid>>()
                .ToTable("Role_Claim")
                .HasKey(x => x.Id);
            #endregion
        }
    }
}
