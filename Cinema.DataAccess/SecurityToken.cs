//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Cinema.DataAccess
{
    using System;
    using System.Collections.Generic;
    
    public partial class SecurityToken
    {
        public System.Guid Id { get; set; }
        public int AccountId { get; set; }
        public System.DateTime ResetRequestDateTime { get; set; }
        public bool IsUsed { get; set; }
    
        public virtual Account Account { get; set; }
    }
}