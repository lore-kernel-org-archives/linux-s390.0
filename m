Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 17 May 2019 15:59:51 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] s390: add unreachable() to dump_fault_info() to fix
 -Wmaybe-uninitialized
Message-ID: <20190517065951.GA11550@jagdpanzerIV>
References: <20190517064922.22743-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517064922.22743-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Souptick Joarder <jrdr.linux@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Philipp Rudo <prudo@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On (05/17/19 15:49), Masahiro Yamada wrote:
[..]
> @@ -211,6 +211,8 @@ static void dump_fault_info(struct pt_regs *regs)
>  		asce = S390_lowcore.kernel_asce;
>  		pr_cont("kernel ");
>  		break;
> +	default:
> +		unreachable();
>  	}
>  	pr_cont("ASCE.\n");
>  	dump_pagetable(asce, regs->int_parm_long & __FAIL_ADDR_MASK);

Or have default fault type and asce?

Just an idea.

---

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index c220399ae196..876d71c31894 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -174,7 +174,8 @@ static void dump_pagetable(unsigned long asce, unsigned long address)
 
 static void dump_fault_info(struct pt_regs *regs)
 {
-	unsigned long asce;
+	unsigned long asce = S390_lowcore.kernel_asce;
+	char *type = "kernel ";
 
 	pr_alert("Failing address: %016lx TEID: %016lx\n",
 		 regs->int_parm_long & __FAIL_ADDR_MASK, regs->int_parm_long);
@@ -197,22 +198,18 @@ static void dump_fault_info(struct pt_regs *regs)
 	switch (get_fault_type(regs)) {
 	case USER_FAULT:
 		asce = S390_lowcore.user_asce;
-		pr_cont("user ");
+		type = "user ";
 		break;
 	case VDSO_FAULT:
 		asce = S390_lowcore.vdso_asce;
-		pr_cont("vdso ");
+		type = "vdso ";
 		break;
 	case GMAP_FAULT:
 		asce = ((struct gmap *) S390_lowcore.gmap)->asce;
-		pr_cont("gmap ");
-		break;
-	case KERNEL_FAULT:
-		asce = S390_lowcore.kernel_asce;
-		pr_cont("kernel ");
+		type = "gmap ";
 		break;
 	}
-	pr_cont("ASCE.\n");
+	pr_cont("%s ASCE.\n", type);
 	dump_pagetable(asce, regs->int_parm_long & __FAIL_ADDR_MASK);
 }
 
