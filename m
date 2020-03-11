Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v3] ima: add a new CONFIG for loading arch-specific
 policies
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 11 Mar 2020 11:42:55 -0400
In-Reply-To: <1583715471-15525-1-git-send-email-nayna@linux.ibm.com>
References: <1583715471-15525-1-git-send-email-nayna@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <1583941375.5293.33.camel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-efi@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Philipp Rudo <prudo@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.vnet.ibm.com>

On Sun, 2020-03-08 at 20:57 -0400, Nayna Jain wrote:
> From: Nayna Jain <nayna@linux.vnet.ibm.com>
> 
> Every time a new architecture defines the IMA architecture specific
> functions - arch_ima_get_secureboot() and arch_ima_get_policy(), the IMA
> include file needs to be updated. To avoid this "noise", this patch
> defines a new IMA Kconfig IMA_SECURE_AND_OR_TRUSTED_BOOT option, allowing
> the different architectures to select it.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Cc: Philipp Rudo <prudo@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>

Thanks, Michael for the suggestion of using "imply".  Seems to be
working nicely.  Thanks, Nayna.  I pushed this patch out to next-
integrity-testing.  Could we get some tags on this version of the
patch?

thanks,

Mimi
