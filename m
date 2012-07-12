From: Jan Glauber <jang@linux.vnet.ibm.com>
Subject: Re: [PATCH 14/14] crypto: arch/s390 - cleanup - remove unneeded
 cra_list initialization
Date: Thu, 12 Jul 2012 11:28:24 +0200
Message-ID: <1342085304.5693.6.camel@localhost.localdomain>
References: <20120711111949.6875.60269.stgit@localhost6.localdomain6>
	 <20120711112101.6875.85841.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <20120711112101.6875.85841.stgit@localhost6.localdomain6>
Sender: linux-crypto-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-crypto/>
List-Post: <mailto:linux-crypto@vger.kernel.org>
To: Jussi Kivilinna <jussi.kivilinna@mbnet.fi>
Cc: linux-crypto@vger.kernel.org, Jan Glauber <jang@de.ibm.com>, linux-s390@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2012-07-11 at 14:21 +0300, Jussi Kivilinna wrote:
> Initialization of cra_list is currently mixed, most ciphers initialize this
> field and most shashes do not. Initialization however is not needed at all
> since cra_list is initialized/overwritten in __crypto_register_alg() with
> list_add(). Therefore perform cleanup to remove all unneeded initializations
> of this field in 'arch/s390/crypto/'
> 
> Cc: Jan Glauber <jang@de.ibm.com>
> Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Jussi Kivilinna <jussi.kivilinna@mbnet.fi>

Signed-off-by: Jan Glauber <jang@linux.vnet.ibm.com>
