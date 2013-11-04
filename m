Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 4 Nov 2013 12:08:49 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: remove unused Kconfig parameters
Message-ID: <20131104110849.GA4117@osiris>
References: <1383558219-5223-1-git-send-email-michael.opdenacker@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1383558219-5223-1-git-send-email-michael.opdenacker@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Michael Opdenacker <michael.opdenacker@free-electrons.com>
Cc: schwidefsky@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Nov 04, 2013 at 10:43:39AM +0100, Michael Opdenacker wrote:
> This removes the HAVE_MARCH_Z900_FEATURES and
> HAVE_MARCH_Z990_FEATURES Kconfig parameters,
> which were no longer used anywhere in the source code
> and Makefiles.
> 
> Actually, HAVE_MARCH_Z990_FEATURES is no longer used
> after removing HAVE_MARCH_Z900_FEATURES.
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>

Thanks for the patch. However each architecture generation is supposed to
have its own "HAVE_MARCH_*" config.
Even if its not used right now, it might create problems in the future
if they are only partially present.
So I'm not going to apply your patch.
