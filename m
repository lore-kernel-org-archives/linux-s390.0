Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="pcF+kuj6"
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FF7AB;
	Tue, 12 Dec 2023 02:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1702375968;
	bh=096hm9ZbRaIMymoQ+0IpHZlm7YvNfwIQuC+ov8MZpxI=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=pcF+kuj6twjNBVCUPQGeJb7my9K+1VvzXPI0J25y/Gn90LiGBj+vWoJl83uX6lb1c
	 drs17TVTFCzPFW61iLjrHsYql3GXgVOGa4GS59KD5CTSYTil8N04Ji6qfiBkifNl95
	 WVcAqudZmxTivJ/eyROH+eHu7ayTS9fiWEN5RTS7VzNdVfNC35s7HvYaUvPSEW6IMo
	 +HHE69xVjML13mdXERyD1TWOOO692oiH7EH/R7AB/nR5ZuNbnFeSHkgPH+E35j5e2D
	 TWjapYdDV//LfS0lZyRU53O3zVjVDdfJc9a6ooJK4P4coQCGrLVRr03uNRRkH8fjHV
	 Uz+qHlhE3q4Cg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 0A9AA12BEC;
	Tue, 12 Dec 2023 11:12:48 +0100 (CET)
Date: Tue, 12 Dec 2023 11:12:47 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Karsten Graul <kgraul@linux.ibm.com>, 
	Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 06/11] net/smc: smc_splice_read: always request
 MSG_DONTWAIT
Message-ID: <145da5ab094bcc7d3331385e8813074922c2a13c6.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20231103
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="suvmg3e3tuoppov4"
Content-Disposition: inline
In-Reply-To: <1cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>


--suvmg3e3tuoppov4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Otherwise we risk sleeping with the pipe locked for indeterminate
lengths of time.

Link: https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5i=
s2ekkaequf4hvode3ls@zgf7j5j4ubvw/t/#u
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 net/smc/af_smc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index bacdd971615e..89473305f629 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3243,12 +3243,8 @@ static ssize_t smc_splice_read(struct socket *sock, =
loff_t *ppos,
 			rc =3D -ESPIPE;
 			goto out;
 		}
-		if (flags & SPLICE_F_NONBLOCK)
-			flags =3D MSG_DONTWAIT;
-		else
-			flags =3D 0;
 		SMC_STAT_INC(smc, splice_cnt);
-		rc =3D smc_rx_recvmsg(smc, NULL, pipe, len, flags);
+		rc =3D smc_rx_recvmsg(smc, NULL, pipe, len, MSG_DONTWAIT);
 	}
 out:
 	release_sock(sk);
--=20
2.39.2

--suvmg3e3tuoppov4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmV4Mh8ACgkQvP0LAY0m
WPEQiQ//dJd64ifmFYk4J0yAhFO+b2YgYYJagGNw6cO4Vvw9R2UjEuuQ/iGnT63B
wTWs58hM8XQjOPjioddYrd8J01pUQQr+L02G7dNKPQErsuCb25aczKMQvZFRCr8c
7ibhOBBZgCpzPMR7bVa8fcvRHDQTLKjMXMJ+HUtNZKT7Kw5g0aaCm6Lh+i/pEk6q
v9nVojhxqOL0OSu+6HQA4Fdn4jfb/vfIXMAnoPb+u3J5Bs7qOM3dUNAPvlbBzYBe
lHtk6rfIbmfSl+X/Knlo3y8CQegd/Tn5zJAMFBeyeBJPRk4cqcZWhz1d3w5acJ7+
1RBznOQ7c7OKAaNJfJtXFT1mln6wjGubsjJ0ATJslr3w1LbDxvAQ7XJwK8QUuNZ0
hRNAxHwXVPOPY41kUU9kxKFmPDjohv+esstreKuYtBaL8EwkKtdhem4wFi4f3dWe
vUpz0lep0VmBjadC44/i2mr79JMNUIQvSHdinBPTB8I/GRjtQeFDNEMn4EEoJQpA
EaMhI9dzoMTc9ofQ2R1L2LPfjO3f5vw/pVtAp6QdAJFX62OlGv/k8z3EhmbPe77A
BQ9WFoq7bYE5Vs61rNeNGaYz/68IWM0VLp0NJ29aaVcLGzUUxBG4eVeDzUZGyizw
1SoMkPuma/i8C8YhuYERKyIpv/K/AU00p/GgctM4uYZwCs8dIDg=
=Q2lp
-----END PGP SIGNATURE-----

--suvmg3e3tuoppov4--
