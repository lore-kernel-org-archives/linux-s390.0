Return-Path: <pavel@ucw.cz>
Date: Wed, 7 Feb 2018 11:02:52 +0100
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 4/6] s390: add options to change branch prediction
 behaviour for the kernel
Message-ID: <20180207100252.GA31392@amd>
References: <1517986811-27819-1-git-send-email-schwidefsky@de.ibm.com>
 <1517986811-27819-5-git-send-email-schwidefsky@de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <1517986811-27819-5-git-send-email-schwidefsky@de.ibm.com>
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>, Dominik Brodowski <linux@dominikbrodowski.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, David Woodhouse <dwmw2@infradead.org>
List-ID: <linux-s390.vger.kernel.org>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-02-07 08:00:09, Martin Schwidefsky wrote:
> Add the PPA instruction to the system entry and exit path to switch
> the kernel to a different branch prediction behaviour. The instructions
> are added via CPU alternatives and can be disabled with the "nospec"
> or the "nobp=3D0" kernel parameter. If the default behaviour selected
> with CONFIG_KERNEL_NOBP is set to "n" then the "nobp=3D1" parameter can be
> used to enable the changed kernel branch prediction.
>=20
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
>  arch/s390/Kconfig                 | 17 ++++++++++++++
>  arch/s390/include/asm/processor.h |  1 +
>  arch/s390/kernel/alternative.c    | 23 +++++++++++++++++++
>  arch/s390/kernel/early.c          |  2 ++
>  arch/s390/kernel/entry.S          | 48 +++++++++++++++++++++++++++++++++=
++++++
>  arch/s390/kernel/ipl.c            |  1 +
>  arch/s390/kernel/smp.c            |  2 ++
>  7 files changed, 94 insertions(+)
>=20
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 0105ce2..d514e25 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -540,6 +540,23 @@ config ARCH_RANDOM
> =20
>  	  If unsure, say Y.
> =20
> +config KERNEL_NOBP
> +	def_bool n
> +	prompt "Enable modified branch prediction for the kernel by default"
> +	help
> +	  If this option is selected the kernel will switch to a modified
> +	  branch prediction mode if the firmware interface is available.
> +	  The modified branch prediction mode improves the behaviour in
> +	  regard to speculative execution.
> +
> +	  With the option enabled the kernel parameter "nobp=3D0" or "nospec"
> +	  can be used to run the kernel in the normal branch prediction mode.
> +
> +	  With the option disabled the modified branch prediction mode is
> +	  enabled with the "nobp=3D1" kernel parameter.
> +
> +	  If unsure, say N.
> +

This could use some improvement.

Afaict the config option only changes the default behaviour? Do we
need the option in such case? (CONFIG_CMDLINE_APPEND can be useful to
avoid some options).

Plus, it is not clear what "modified branch prediction mode is" and if
"improves behaviour" means "faster" or "safer".

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlp6zswACgkQMOfwapXb+vK0pwCeL4PEbHal/xjwNBCka4uCa8VM
w+IAn2Hj1tcYhZp0gdFqCfL+gIpsooAF
=wjN7
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
