Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 27 Sep 2014 09:57:01 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: remove unused Kconfig params
Message-ID: <20140927075701.GA6926@osiris>
References: <1411799130-17875-1-git-send-email-michael.opdenacker@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1411799130-17875-1-git-send-email-michael.opdenacker@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Michael Opdenacker <michael.opdenacker@free-electrons.com>
Cc: schwidefsky@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, Sep 27, 2014 at 08:25:30AM +0200, Michael Opdenacker wrote:
> Remove the below Kconfig parameters, which are no longer
> used anywhere in the source code and Makefiles:
> 
> HAVE_MARCH_Z900_FEATURES
> HAVE_MARCH_Z990_FEATURES
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>

What I wrote you a year ago is still true:

https://lkml.org/lkml/2013/11/4/69

Thanks,
Heiko
