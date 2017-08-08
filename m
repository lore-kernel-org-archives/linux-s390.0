From: Benjamin Block <bblock@linux.vnet.ibm.com>
Subject: Re: [PATCH 00/22] zfcp fixes and cleanups
Date: Tue, 8 Aug 2017 12:02:24 +0200
Message-ID: <20170808100224.GA13050@bblock-ThinkPad-W530>
References: <cover.1501085249.git.bblock@linux.vnet.ibm.com>
 <yq13793b8j4.fsf@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <yq13793b8j4.fsf@oracle.com>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>, Steffen Maier <maier@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Aug 07, 2017 at 01:19:11PM -0400, Martin K. Petersen wrote:
> > here is a series of (important) fixes and some additional cleanups for
> > the zfcp driver. Our fixes are marked for stable accordingly.
> >
> > Patches 01 - 04 are cleanups and external patches (also cleanups) that =
we
> >       & 13 - 22     had queued for quite some time now
> >
> > Patches 05 - 12 are driver fixes that are all marked for stable as well
>=20
> Given the ordering, it's a bit unclear how you want me to apply these.
>=20
> There are a bunch of fixes you labeled as "important" but they are not
> at the beginning of the series. And I am not sure if these have
> dependencies on the preceding cleanup patches?
>=20
> If you have fixes you would like to get into 4.13, please post those
> first as a separate series. And clearly indicate that that's the branch
> you are aiming for.
>=20
> If you are OK with everything going into 4.14, then let me know. In that
> case you don't have to shuffle the patches around.
>=20

I think it is OK for us, if this goes into 4.14 as one series. So if it
is OK with you, just apply the complete series for that.

Thanks.



                                                    Beste Gr=FC=DFe / Best =
regards,
                                                      - Benjamin Block
--=20
Linux on z Systems Development         /         IBM Systems & Technology G=
roup
		  IBM Deutschland Research & Development GmbH=20
Vorsitz. AufsR.: Martina Koederitz     /        Gesch=E4ftsf=FChrung: Dirk =
Wittkopp
Sitz der Gesellschaft: B=F6blingen / Registergericht: AmtsG Stuttgart, HRB =
243294
