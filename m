Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <0d72bc0b518c416d32e11abfacda36e6370b8f2c.camel@perches.com>
Subject: Re: [PATCH 19/29] s390/tty3270: Avoid comma separated statements
From: Joe Perches <joe@perches.com>
Date: Sat, 30 Jan 2021 11:01:21 -0800
In-Reply-To: <9988babd9cca4ac841961d9f0bbf5e49caa87659.1598331149.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
         <9988babd9cca4ac841961d9f0bbf5e49caa87659.1598331149.git.joe@perches.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On Mon, 2020-08-24 at 21:56 -0700, Joe Perches wrote:
> Use semicolons and braces.

ping?

> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> =EF=BF=BDdrivers/s390/char/tty3270.c | 6 ++++--
> =EF=BF=BD1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
> index aec996de44d9..6acce975df26 100644
> --- a/drivers/s390/char/tty3270.c
> +++ b/drivers/s390/char/tty3270.c
> @@ -424,8 +424,10 @@ tty3270_update(struct timer_list *t)
> =EF=BF=BD			 * last output position matches the start address
> =EF=BF=BD			 * of this line.
> =EF=BF=BD			 */
> -			if (s->string[1] =3D=3D sba[0] && s->string[2] =3D=3D sba[1])
> -				str +=3D 3, len -=3D 3;
> +			if (s->string[1] =3D=3D sba[0] && s->string[2] =3D=3D sba[1]) {
> +				str +=3D 3;
> +				len -=3D 3;
> +			}
> =EF=BF=BD			if (raw3270_request_add_data(wrq, str, len) !=3D 0)
> =EF=BF=BD				break;
> =EF=BF=BD			list_del_init(&s->update);
