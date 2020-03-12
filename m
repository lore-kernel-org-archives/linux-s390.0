Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3] ima: add a new CONFIG for loading arch-specific policies
In-Reply-To: <1583715471-15525-1-git-send-email-nayna@linux.ibm.com>
References: <1583715471-15525-1-git-send-email-nayna@linux.ibm.com>
Date: Thu, 12 Mar 2020 22:15:54 +1100
Message-ID: <87d09hj02d.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-efi@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Philipp Rudo <prudo@linux.ibm.com>, zohar@linux.ibm.com, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.vnet.ibm.com>

Nayna Jain <nayna@linux.ibm.com> writes:
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
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Philipp Rudo <prudo@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> ---
> v3:
> * Removes CONFIG_IMA dependency. Thanks Ard.
> * Updated the patch with improvements suggested by Michael. It now uses
> "imply" instead of "select". Thanks Michael.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
