From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Fri, 29 Mar 2013 17:22:00 +0000
Subject: Re: sound/soc/codecs/wm8903.c:2043:9: error: implicit declaration of function 'irq_get_irq_data'
Message-Id: <20130329172200.GE18316@opensource.wolfsonmicro.com>
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF2A74F42F7E@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF2A74F42F7E@HQMAIL01.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--PZgnm7T+MVPmWSUE"
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


--PZgnm7T+MVPmWSUE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 29, 2013 at 08:28:35AM -0700, Stephen Warren wrote:
> Fengguang Wu wrote at Thursday, March 28, 2013 8:36 PM:

> >    sound/soc/codecs/wm8903.c: In function 'wm8903_set_pdata_irq_trigger':
> > >> sound/soc/codecs/wm8903.c:2043:9: error: implicit declaration of function 'irq_get_irq_data' [-
> > Werror=implicit-function-declaration]

> I guess this is all because !CONFIG_GENERIC_HARDIRQs on s390. s390 and um
> appear to be the only architectures that don't enable that option. Should
> we just make the WM8903 driver depend on GENERIC_HARDIRQs? I'd imagine this
> could easily affect a variety of other drivers though.

It seems much more useful to fix this on the architecture side, I think
that this point the generic interrupt API is something we ought to be
able to just rely on.

--PZgnm7T+MVPmWSUE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRVc1uAAoJELSic+t+oim9xbYP/je6ZqdMoRSNpRlf+ZFJ+7OF
RXAqV+r3iNFZTmgoGgYx0Ik4AERQyN/+R1d6vYKFRSvwRbKCA/4+HRekzDZ/z01Y
A9WAVzkaX/gh8ThtE7fk/pw6Ts3zf2E3zcL8PeN1YRmBGEPuSNNu1vRXSy96+QaT
LSAh1M0bP6/GcpqaEj7xXOgIS3NOAAR4vaiBMNmaE86Ys5WxuVB3CX99z6bji7y7
IR46paqODkGO1RMDlwYftQ/VXTYwjgVWfPcL8y4C72md+fU2nJLtOAWNZMc8YMPH
x/Q8LNGVespr5I/JyewAcrwYk5SsW7j+BVSZWtNATINTQ3raVOq4Y4+vNLav2bys
FalbB65PEx5zoTFUlLjNmgqZTSrSKVkw0aBZHncVj7qpb4jvB1VfoN07+y2ZPmEx
q8cXhzX2ZlVCaschZfF4jZR5CeefffFoJCW+eWWB003ZBLv7GszYBtrLxy8JZFKs
cNIA3bx4sDZssEmkpGJ5m8CK8XH7Tte2yfjCtnFadXY6gXrvNJu7Zs7Kgnjw3jTE
ur0vhIGVT/VhPGCI8XmVVAymhNU0GAcyjfgSlGreLmkZSRwMRO0z/M1dgQdkNL/C
4+jabkDsRdPa06sqEivMOUafYZGZ4ahQOxDl0WMarRhGLGDHC0NTs2uG71NJO7sc
yOjVxv7EhBLsMXgNxxyD
=7avX
-----END PGP SIGNATURE-----

--PZgnm7T+MVPmWSUE--
