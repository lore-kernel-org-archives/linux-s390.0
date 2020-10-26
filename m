Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 27 Oct 2020 00:57:00 +0100
From: Michal Kubecek <mkubecek@suse.cz>
Subject: Re: [PATCH 1/1] s390: correct __bootdata / __bootdata_preserved
 macros
Message-ID: <20201026235700.3dga6r5obn7z5cxv@lion.mk-sys.cz>
References: <20201026104811.22ta4pby2chmz4pv@lion.mk-sys.cz>
 <cover.thread-96dc81.your-ad-here.call-01603716370-ext-5478@work.hours>
 <patch-1.thread-96dc81.git-96dc8112cea9.your-ad-here.call-01603716370-ext-5478@work.hours>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qcfgs5eg7rfckcnu"
Content-Disposition: inline
In-Reply-To: <patch-1.thread-96dc81.git-96dc8112cea9.your-ad-here.call-01603716370-ext-5478@work.hours>
List-ID: <linux-s390.vger.kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>


--qcfgs5eg7rfckcnu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 01:49:08PM +0100, Vasily Gorbik wrote:
> Currently s390 build is broken.
>=20
>   SECTCMP .boot.data
> error: section .boot.data differs between vmlinux and arch/s390/boot/comp=
ressed/vmlinux
> make[2]: *** [arch/s390/boot/section_cmp.boot.data] Error 1
>   SECTCMP .boot.preserved.data
> error: section .boot.preserved.data differs between vmlinux and arch/s390=
/boot/compressed/vmlinux
> make[2]: *** [arch/s390/boot/section_cmp.boot.preserved.data] Error 1
> make[1]: *** [bzImage] Error 2
>=20
> Commit 33def8498fdd ("treewide: Convert macro and uses of __section(foo)
> to __section("foo")") converted all __section(foo) to __section("foo").
> This is wrong for __bootdata / __bootdata_preserved macros which want
> variable names to be a part of intermediate section names .boot.data.<var
> name> and .boot.preserved.data.<var name>. Those sections are later
> sorted by alignment + name and merged together into final .boot.data
> / .boot.preserved.data sections. Those sections must be identical in
> the decompressor and the decompressed kernel (that is checked during
> the build).
>=20
> Fixes: 33def8498fdd ("treewide: Convert macro and uses of __section(foo) =
to __section("foo")")
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

Tested-by: Michal Kubecek <mkubecek@suse.cz>

Thank you,
Michal

> ---
>  arch/s390/include/asm/sections.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/s390/include/asm/sections.h b/arch/s390/include/asm/sec=
tions.h
> index a996d3990a02..0c2151451ba5 100644
> --- a/arch/s390/include/asm/sections.h
> +++ b/arch/s390/include/asm/sections.h
> @@ -26,14 +26,14 @@ static inline int arch_is_kernel_initmem_freed(unsign=
ed long addr)
>   * final .boot.data section, which should be identical in the decompress=
or and
>   * the decompressed kernel (that is checked during the build).
>   */
> -#define __bootdata(var) __section(".boot.data.var") var
> +#define __bootdata(var) __section(".boot.data." #var) var
> =20
>  /*
>   * .boot.preserved.data is similar to .boot.data, but it is not part of =
the
>   * .init section and thus will be preserved for later use in the decompr=
essed
>   * kernel.
>   */
> -#define __bootdata_preserved(var) __section(".boot.preserved.data.var") =
var
> +#define __bootdata_preserved(var) __section(".boot.preserved.data." #var=
) var
> =20
>  extern unsigned long __sdma, __edma;
>  extern unsigned long __stext_dma, __etext_dma;
> --=20
> 2.25.4

--qcfgs5eg7rfckcnu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAl+XYkcACgkQ538sG/LR
dpWkIQf/ewe8ufeiPuicJmlgaV6TdHL3FAT8qcv6mHaTsLLX7wyxKw5IAjV7MQ5v
qjREkYseptZ88CaoU6Rhzc1iGY2ugIpdQpPRrr/CbvgH5Kaw7AH0Ii9C/60W1CY8
zJl9UPKuOV/s5RiMA1gP0AKTDNVGLk35/GYKh4GnvIIoY1jjxkoaoGqew+jBkCc8
H6bJfChAHqb0YEhiOrB6quwEDbFBmongolgMmpHJ/kenhW/IeOyT1TRDt00jFr6i
rpHMS48r4uhi5M0srNOW71mptisTBR1rjMzz/2maaNv8yntJsEFN3J2RbQ3Z/x1c
TZ7UujMj5rSBT/RjXFwZcjPCp8KxOQ==
=9yg/
-----END PGP SIGNATURE-----

--qcfgs5eg7rfckcnu--
