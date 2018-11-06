From: Mark Brown <broonie@kernel.org>
Subject: Re: Build regressions/improvements in v4.20-rc1
 (sound/pci/hda/patch_ca0132.c)
Date: Tue, 6 Nov 2018 15:46:59 +0000
Message-ID: <20181106154659.GA31950@sirena.org.uk>
References: <20181105220559.27458-1-geert@linux-m68k.org>
 <CAMuHMdWGpjvwunNWgFujPO9_j+=QiNsi346s4-xBF1g4DT5xZw@mail.gmail.com>
 <80f2f98b-9ab1-2a1c-0962-63e3be1dd742@infradead.org>
 <CAMuHMdViTrKqQzci3=YJzk2+kQKqbWcr0oaaR1ZQM_VqT33RvA@mail.gmail.com>
 <eccd20fa-5be3-957d-7905-9cc4021ba94e@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4218859509696698923=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <eccd20fa-5be3-957d-7905-9cc4021ba94e@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
List-Archive: <https://lore.kernel.org/alsa-devel/>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux-sh list <linux-sh@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-ID: <linux-s390.vger.kernel.org>


--===============4218859509696698923==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 06, 2018 at 08:56:39AM -0600, Pierre-Louis Bossart wrote:

> > However, looking at what else can enable SND_HDA, I think it should be

> >      select SND_SOC_HDAC_HDA if SND_PCI || ARCH_TEGRA

> This codec can only be used by the Skylake driver (and the upcoming SOF
> one). For Tegra this module will never be used unless they follow the same
> path of enabling ASoC to deal with the HDaudio codecs instead of the legacy.

> Likewise HDAC_HDMI will only work on Intel platforms for now.

_ALL_CODECS is a build coverage option, not a useful configuration
option.  We should be building things in as many different
configurations as possible so that it's easier for people to get build
coverage when making subsystem wide changes.

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvht3EACgkQJNaLcl1U
h9Deagf+OnHg8fBz8mKu9ehkKNp8xTUnAUdpPtoS0edsuI0QuH1I5WbIs6F3Ro58
cxf6scOiMI7R0/qne0h0ReQbOudbh0mT0aCBL1UP77FGvWhkgpJF8CkJP5Hwl+MB
eFtQe4CE0IfCXtzbfhg+RZ22OkUmJ4Rgdue5yqS7fPHswqQb/7zMGXZpKYGHuJx5
T1Dhj5dnKqI7pS8lThDzcA/ZtkBbST4aN+Zv1RvI9ew6pVMrYWq30QSohmx2+qTs
A9ESsst56DEvX8RSIZcsqMNejmuXFIQ4L7dqyIjS/9FjLoG1fp5SUkSOd4p6NHoo
BBLuGM/ddEXdoSs7PJGNuK+CihZHtA==
=wMGV
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--

--===============4218859509696698923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4218859509696698923==--
