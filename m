Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-148.mimecast.com ([63.128.21.148]:32689 "EHLO
        us-smtp-delivery-148.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726173AbgHJK1G (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Aug 2020 06:27:06 -0400
From: "Van Leeuwen, Pascal" <pvanleeuwen@rambus.com>
Subject: RE: [PATCH 19/22] crypto: inside-secure - add check for xts input
 length equal to zero
Date: Mon, 10 Aug 2020 10:20:20 +0000
Message-ID: <CY4PR0401MB36528610C3ABF802F8CBF35FC3440@CY4PR0401MB3652.namprd04.prod.outlook.com>
References: <20200807162010.18979-1-andrei.botila@oss.nxp.com>
 <20200807162010.18979-20-andrei.botila@oss.nxp.com>
In-Reply-To: <20200807162010.18979-20-andrei.botila@oss.nxp.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrei Botila <andrei.botila@oss.nxp.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Cc: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>, Andrei Botila <andrei.botila@nxp.com>, Antoine Tenart <antoine.tenart@bootlin.com>

> -----Original Message-----
> From: linux-crypto-owner@vger.kernel.org <linux-crypto-owner@vger.kernel.=
org> On Behalf Of Andrei Botila
> Sent: Friday, August 7, 2020 6:20 PM
> To: Herbert Xu <herbert@gondor.apana.org.au>; David S. Miller <davem@dave=
mloft.net>
> Cc: linux-crypto@vger.kernel.org; linux-arm-kernel@lists.infradead.org; l=
inux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> linux-s390@vger.kernel.org; x86@kernel.org; linux-arm-kernel@axis.com; An=
drei Botila <andrei.botila@nxp.com>; Antoine Tenart
> <antoine.tenart@bootlin.com>
> Subject: [PATCH 19/22] crypto: inside-secure - add check for xts input le=
ngth equal to zero
>
> <<< External Email >>>
> From: Andrei Botila <andrei.botila@nxp.com>
>
> Standardize the way input lengths equal to 0 are handled in all skcipher
> algorithms. All the algorithms return 0 for input lengths equal to zero.
>
> Cc: Antoine Tenart <antoine.tenart@bootlin.com>
> Signed-off-by: Andrei Botila <andrei.botila@nxp.com>
> ---
>  drivers/crypto/inside-secure/safexcel_cipher.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/crypto/inside-secure/safexcel_cipher.c b/drivers/cry=
pto/inside-secure/safexcel_cipher.c
> index 1ac3253b7903..03d06556ea98 100644
> --- a/drivers/crypto/inside-secure/safexcel_cipher.c
> +++ b/drivers/crypto/inside-secure/safexcel_cipher.c
> @@ -2533,6 +2533,9 @@ static int safexcel_skcipher_aes_xts_cra_init(struc=
t crypto_tfm *tfm)
>
>  static int safexcel_encrypt_xts(struct skcipher_request *req)
>  {
> +if (!req->cryptlen)
> +return 0;
> +
>  if (req->cryptlen < XTS_BLOCK_SIZE)
>  return -EINVAL;
>  return safexcel_queue_req(&req->base, skcipher_request_ctx(req),
> @@ -2541,6 +2544,9 @@ static int safexcel_encrypt_xts(struct skcipher_req=
uest *req)
>
>  static int safexcel_decrypt_xts(struct skcipher_request *req)
>  {
> +if (!req->cryptlen)
> +return 0;
> +
>  if (req->cryptlen < XTS_BLOCK_SIZE)
>  return -EINVAL;
>  return safexcel_queue_req(&req->base, skcipher_request_ctx(req),
> --
> 2.17.1

With all due respect, but this makes no sense.

For XTS, any length below 16 is illegal, as applying CTS in order to handle=
 non-cipher
block multiples (16 bytes in case of AES) requires _more_ data than 1 ciphe=
r block.

There is no benefit to explicitly check for zero length if there is already=
 a check for
less-than-16. That's just wasting CPU cycles and  a branch predictor entry,=
 for no
benefit whatsoever. (except for academic "alignment with other ciphers").

XTS has very specific use cases. No one in their right mind would call it f=
or a
situation where it can't be applied in the first place, e.g. anything < 16 =
bytes.

Regards,
Pascal van Leeuwen
Silicon IP Architect Multi-Protocol Engines, Rambus Security
Rambus ROTW Holding BV
+31-73 6581953

Note: The Inside Secure/Verimatrix Silicon IP team was recently acquired by=
 Rambus.
Please be so kind to update your e-mail address book with my new e-mail add=
ress.


** This message and any attachments are for the sole use of the intended re=
cipient(s). It may contain information that is confidential and privileged.=
 If you are not the intended recipient of this message, you are prohibited =
from printing, copying, forwarding or saving it. Please delete the message =
and attachments and notify the sender immediately. **

Rambus Inc.<http://www.rambus.com>
