Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20200807162010.18979-1-andrei.botila@oss.nxp.com> <20200807162010.18979-17-andrei.botila@oss.nxp.com>
In-Reply-To: <20200807162010.18979-17-andrei.botila@oss.nxp.com>
From: Gilad Ben-Yossef <gilad@benyossef.com>
Date: Sat, 8 Aug 2020 15:10:33 +0300
Message-ID: <CAOtvUMero-gF5ZE1unnD_wcDnzZX_SL0tQ2yJNqzc3rg5RhuDA@mail.gmail.com>
Subject: Re: [PATCH 16/22] crypto: ccree - add check for xts input length
 equal to zero
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrei Botila <andrei.botila@oss.nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390@vger.kernel.org, x86@kernel.org, linux-arm-kernel@axis.com, Andrei Botila <andrei.botila@nxp.com>

On Fri, Aug 7, 2020 at 7:22 PM Andrei Botila <andrei.botila@oss.nxp.com> wr=
ote:
>
> From: Andrei Botila <andrei.botila@nxp.com>
>
> Standardize the way input lengths equal to 0 are handled in all skcipher
> algorithms. All the algorithms return 0 for input lengths equal to zero.
> This change has implications not only for xts(aes) but also for cts(cbc(a=
es))
> and cts(cbc(paes)).
>
> Cc: Gilad Ben-Yossef <gilad@benyossef.com>
> Signed-off-by: Andrei Botila <andrei.botila@nxp.com>
> ---
>  drivers/crypto/ccree/cc_cipher.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_c=
ipher.c
> index 076669dc1035..112bb8b4dce6 100644
> --- a/drivers/crypto/ccree/cc_cipher.c
> +++ b/drivers/crypto/ccree/cc_cipher.c
> @@ -912,17 +912,18 @@ static int cc_cipher_process(struct skcipher_reques=
t *req,
>
>         /* STAT_PHASE_0: Init and sanity checks */
>
> -       if (validate_data_size(ctx_p, nbytes)) {
> -               dev_dbg(dev, "Unsupported data size %d.\n", nbytes);
> -               rc =3D -EINVAL;
> -               goto exit_process;
> -       }
>         if (nbytes =3D=3D 0) {
>                 /* No data to process is valid */
>                 rc =3D 0;
>                 goto exit_process;
>         }
>
> +       if (validate_data_size(ctx_p, nbytes)) {
> +               dev_dbg(dev, "Unsupported data size %d.\n", nbytes);
> +               rc =3D -EINVAL;
> +               goto exit_process;
> +       }
> +
>         if (ctx_p->fallback_on) {
>                 struct skcipher_request *subreq =3D skcipher_request_ctx(=
req);
>
> --
> 2.17.1
>

Acked-by: Gilad Ben-Yossef <gilad@benyossef.com>

Thanks,
Gilad

--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
