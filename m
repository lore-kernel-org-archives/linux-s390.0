Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 17 Feb 2014 09:20:35 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: remove HAVE_MARCH_Z9?0_FEATURES
Message-ID: <20140217082035.GA4651@osiris>
References: <1392570927.28866.12.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392570927.28866.12.camel@x220>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, Feb 16, 2014 at 06:15:27PM +0100, Paul Bolle wrote:
> The Kconfig symbols HAVE_MARCH_Z900_FEATURES and
> HAVE_MARCH_Z990_FEATURES were added in v3.5. They have never been used.
> Apparently they are not needed. They can safely be removed.
> 

No, I want to keep them, so there is a config symbol for each cpu generation
and we don't have to add the config symbols again, if we actually use them.
It's a question of completeness in this case, not if they are being used.

Thanks,
Heiko
