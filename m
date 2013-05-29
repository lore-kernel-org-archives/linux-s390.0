From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH v2] arch: s390: appldata: using strncpy() and strnlen()
 instead of sprintf()
Date: Wed, 29 May 2013 15:29:01 +0800
Message-ID: <51A5AE3D.5080106@asianux.com>
References: <51A48EE9.2040401@asianux.com> <51A32D81.2010105@asianux.com> <51A2CC07.5010100@asianux.com> <CAMuHMdXTW3QOxfAfqQXdbSpP4R83srFf7eMfu5fA-75S_Mujsg@mail.gmail.com> <4310.1369736553@warthog.procyon.org.uk> <5895.1369743429@warthog.procyon.org.uk> <51A559CB.3020804@asianux.com> <20130529063020.GG23932@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20130529063020.GG23932@mwanda>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: David Howells <dhowells@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, jang@linux.vnet.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 05/29/2013 02:30 PM, Dan Carpenter wrote:
> On Wed, May 29, 2013 at 09:28:43AM +0800, Chen Gang wrote:
> 
>> > diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
>> > index bae0f40..27f200d 100644
>> > --- a/arch/s390/appldata/appldata_base.c
>> > +++ b/arch/s390/appldata/appldata_base.c
>> > @@ -212,10 +212,9 @@ appldata_timer_handler(ctl_table *ctl, int write,
>> >  		return 0;
>> >  	}
>> >  	if (!write) {
>> > -		len = sprintf(buf, appldata_timer_active ? "1\n" : "0\n");
>> > -		if (len > *lenp)
>> > -			len = *lenp;
>> > -		if (copy_to_user(buffer, buf, len))
>> > +		if (copy_to_user(buffer,
>> > +				 appldata_timer_active ? "1\n" : "0\n",
>> > +				 min(2, *lenp))
> I don't have a cross compiler set up, but this will generate a
> warning, I think.  min_t() is needed.

Yes, it even can not pass compiling: need additional ')' for 'if'.

The new fix is below, (for pass compiling, also need fix the incorrect
declaration, which I have already sent an individual patch for it).

-----------------------------diff v2 begin------------------------------

diff --git a/arch/s390/appldata/appldata_base.c
b/arch/s390/appldata/appldata_base.c
index bae0f40..b0915b4 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -212,10 +212,9 @@ appldata_timer_handler(ctl_table *ctl, int write,
 		return 0;
 	}
 	if (!write) {
-		len = sprintf(buf, appldata_timer_active ? "1\n" : "0\n");
-		if (len > *lenp)
-			len = *lenp;
-		if (copy_to_user(buffer, buf, len))
+		if (copy_to_user(buffer,
+				 appldata_timer_active ? "1\n" : "0\n",
+				 min_t(size_t, 2, *lenp)))
 			return -EFAULT;
 		goto out;
 	}
diff --git a/arch/s390/include/asm/pgtable.h
b/arch/s390/include/asm/pgtable.h
index 172209c..ed88890 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1348,7 +1348,7 @@ static inline pmd_t pmd_mkwrite(pmd_t pmd)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE

 #define __HAVE_ARCH_PGTABLE_DEPOSIT
-extern void pgtable_trans_huge_deposit(struct mm_struct *mm, , pmd_t *pmdp,
+extern void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 				       pgtable_t pgtable);

 #define __HAVE_ARCH_PGTABLE_WITHDRAW


-----------------------------diff v2 end--------------------------------


For cross compiler, I use fedora 16/17, can yum update binutils-*
to get many platform cross-compilers (s390, powerpc, arm, xtensa, ...).


Thanks.
-- 
Chen Gang

Asianux Corporation
