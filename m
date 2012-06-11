Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] crypto: s390 - clean up DES code a bit more
From: Jan Glauber <jang@linux.vnet.ibm.com>
In-Reply-To: <1339194367.30984.18.camel@x61.thuisdomein>
References: <1339194367.30984.18.camel@x61.thuisdomein>
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 11 Jun 2012 10:34:39 +0200
Message-ID: <1339403679.9116.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Herbert Xu <herbert@gondor.hengli.com.au>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, 2012-06-09 at 00:26 +0200, Paul Bolle wrote:
> Commit 98971f8439b1bb9a61682fe24a865ddd25167a6b ("crypto: s390 - cleanup
> DES code") should have also removed crypto_des.h. That file is unused
> and unneeded since that commit. So let's clean up that file too.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Untested. Ought to be correct.
> 
>  arch/s390/crypto/crypto_des.h |   18 ------------------
>  1 files changed, 0 insertions(+), 18 deletions(-)
>  delete mode 100644 arch/s390/crypto/crypto_des.h

Looks good!

Acked-by: Jan Glauber <jang@linux.vnet.ibm.com>
