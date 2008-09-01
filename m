From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: + separate-atomic_t-declaration-from-asm-atomich-into-asm-atomic_defh.patch added to -mm tree
Date: Mon, 1 Sep 2008 11:21:40 +0200
Message-ID: <200809011121.40686.borntraeger@de.ibm.com>
References: <200808222056.m7MKucHA016131@imap1.linux-foundation.org> <20080822213624.GX8318@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20080822213624.GX8318@parisc-linux.org>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: akpm@linux-foundation.org, mm-commits@vger.kernel.org, ying.huang@intel.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Am Freitag, 22. August 2008 schrieb Matthew Wilcox:
> 
> S390 has an __aligned__((4)) on theirs -- is this really necessary?
> Doesn't s390 align ints to 4 bytes automatically?  If it doesn't, it

Yes, the s390 abi requires a 4 byte alignment for int. The __aligned__((4))
looks unnecessary. 

> +++ include/linux/atomic_type.h
> +typedef struct { volatile int counter; } atomic_t;
> +#ifdef CONFIG_64BIT
> +typedef struct { volatile long counter; } atomic64_t;
> +#endif

Hmm, the current s390 version has no volatile. I can recall some very long 
mail threads about this. What was the outcome?

Christian
