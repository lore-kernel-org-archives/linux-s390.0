From: Felipe Balbi <balbi@ti.com>
Date: Tue, 02 Apr 2013 07:57:09 +0000
Subject: Re: drivers/usb/gadget/pch_udc.c:1405:3: error: implicit declaration of function 'irq_set_irq_type'
Message-Id: <20130402075709.GA30286@arwen.pp.htv.fi>
In-Reply-To: <CANKRQnjzAZ+FymhRc5Re6i7QbpjQsLsXwXXPqhUmBbHPS7X7LQ@mail.gmail.com>
References: <CANKRQnjzAZ+FymhRc5Re6i7QbpjQsLsXwXXPqhUmBbHPS7X7LQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--SUOF0GtieIMvvwua"
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 01, 2013 at 08:52:26AM +0900, Tomoya MORINAGA wrote:
> This driver works only for X86, especially, Intel Atom E6XX series.
> I should have written X86 definition to Kconfig.

pleaes don't. I rather see this driver compiling everywhere.

--=20
balbi

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRWo9VAAoJEIaOsuA1yqRE5hIP/0nkl0cPHrzXkTe9wTY0PjSI
2rgN7UApE2ZPRt4BtewmJEZuXzTCFWfskC8jFXx0n5tc5mlD5F+l3jtiX7p/nfyO
CTSmTa7DGEJ6y20io0aCBAdWmdwpumYz3yZJJCS5Amu/thOPcPvc6A8OeuKnPJJ/
8x1HdpOhfY+yr3uSAUXo1v98qz78RBl+hkcTp/6hjmWWZxxiiYZ4dIpdaGMOJJ+b
h+5+yZ3HDMBlm1j8IZnqC4bRLki38ik5A8484VAyrsyx7g++hIaaVEE7s9cXjX3w
geBW0ux+Lzq8klvFtwvRFGjLCpC8GtaqiXm/vJNmjF5Xf92J+ocgCiCLaeiG8jZn
DZv6dYzpQEKanebPeYK2RhXyXSIifQR73LHKfMXEV6pk9DZsZWGrrfhq5Kp1EGTf
A35EQcBojUK1xB6FcYIsuLolNauVp130cbafhlfkr05gGDzDcnWlZDpfgtTJFBsM
5xoEVpLxvGP7vVTmgwUBib/h1XUD++KTaEVAf6+AoQ7kOY/fKdRjHXBxDguf66Ds
tBObEqK8bInsMsVZEW9Nbd+bCWLKymsbv8VlEWq1zu52pZ1rr7OnAfLcSk65s+EU
S6MZo4bPk5OCL542EhrQzMFb9sq2ZYSnyGrySCX7RsTO1fIIJ/qhcL1hZJdISEoL
868TCOB4aJCWCnvN/+dt
=ASly
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
