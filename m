Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 3 Dec 2018 13:11:53 +0100 (CET)
From: Sebastian Ott <sebott@linux.ibm.com>
Subject: Re: [PATCH] s390: convert to DEFINE_SHOW_ATTRIBUTE
In-Reply-To: <20181202032811.9875-1-tiny.windzz@gmail.com>
References: <20181202032811.9875-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.21.1812031310340.1928@schleppi.aag-de.ibmmobiledemo.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: sth@linux.ibm.com, hoeppner@linux.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, oberpar@linux.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, 1 Dec 2018, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/s390/block/dasd.c     | 15 +--------------
>  drivers/s390/cio/qdio_debug.c | 16 ++--------------
>  2 files changed, 3 insertions(+), 28 deletions(-)

Applied, thanks!
Sebastian
