Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] ima: add a new CONFIG for loading arch-specific policies
References: <1582744207-25969-1-git-send-email-nayna@linux.ibm.com>
From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <94fe39a9-db9e-211d-d9b7-4cfe1a270e6f@linux.microsoft.com>
Date: Wed, 26 Feb 2020 11:21:28 -0800
MIME-Version: 1.0
In-Reply-To: <1582744207-25969-1-git-send-email-nayna@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-efi@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Philipp Rudo <prudo@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, zohar@linux.ibm.com, linux-kernel@vger.kernel.org

Hi Nayna,

> +
> +config IMA_SECURE_AND_OR_TRUSTED_BOOT
> +	bool
> +	depends on IMA
> +	depends on IMA_ARCH_POLICY
> +	default n
> +	help
> +	   This option is selected by architectures to enable secure and/or
> +	   trusted boot based on IMA runtime policies.
> 

Why is the default for this new config "n"?
Is there any reason to not turn on this config if both IMA and 
IMA_ARCH_POLICY are set to y?

thanks,
  -lakshmi
