Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35252DF42;
	Fri, 11 Jul 2025 00:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752193595; cv=pass; b=LmmmcIQ8hDzH64yojVZ0zkdibpSJFF6nLCQ6Tx1+ZSa4NliJuGNXUFhj5ykQob2h9k6bVArlNdfEeVe3dAU2PlILvy+JIfAegOrqXI+x8h7WRjeMr45UuvwlcY0EZpYIObza2jhiHwCUvjWwK5NeqzjklSAyURA0Qxt0txqjtPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752193595; c=relaxed/simple;
	bh=qGaSIfaAyNW7dVwNfHz6VldhcAIWtpLeNfZhRrkdONw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=LWesIXz7yjGwy976FviCewlBkuFqgSOFrN39lwGCZuJSU+WBfkfzGrMcj5OwcepBog7Ghi5w+N2+b3bSGHjSae2v40s4/erV1mNXiGZRjJ55m9dhHc0+2p84rYAviTSWbYm5rQ202HN2b6JF1yp8zmk6P6WVPffCHY3plsOVCr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=SwX7Ky0Z; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="SwX7Ky0Z"
ARC-Seal: i=1; a=rsa-sha256; t=1752193502; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Y7iShuCKuWRtC1eSfY8suvhgtBlX1OLua0p+xXXP4ngfWcNSIdFTFRM+cHuvStnV2kzcmX7h3bAY7S0V1Tg7Oy+uRn9v/pm2c/65sWtYHsAZiiM3QZ7HJEEmndhEBf3iU/j4ttoU3GO/KF6aNu+wy1UGp1oXwjA+Gg+/PSaz1fY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752193502; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Cso21EcGT/s8s2wk1z/Mf8lcRLKY5dQSvb6M9DdLo+w=; 
	b=Kc1galt7OOo4SfDw6GAmMJm6W8k5AF3nJO3PsnRCtsDXC4+i79GB6XhH+bgzSNJBZK2FuNBQzbQ2ggMNhSfKYfaiCV0U3c3RVHqMvwAVzxhP9hnC3u4vhO3Prc1aswwB45edX/W2aWHn7TP1O67bpRQHDykPiVCA3WIJuQSiPdk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752193502;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Cso21EcGT/s8s2wk1z/Mf8lcRLKY5dQSvb6M9DdLo+w=;
	b=SwX7Ky0ZXjAojYyMiIJ5PBtLOgT97rgGLACle/VZpOHSqbKx4PxnGF3mtyhEorrd
	Gl3SgstpU9z5VldnMnCvMVTnm/2BLChe/Lwroti0oViFjbaBO0MHupozj2wTdwJyMFT
	myxGUAZtKxsoAzaFugsXgK6nD03/xxhcGehVUqmk=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1752193499988464.8625971507744; Thu, 10 Jul 2025 17:24:59 -0700 (PDT)
Date: Fri, 11 Jul 2025 08:24:59 +0800
From: Li Chen <me@linux.beauty>
To: "K Prateek Nayak" <kprateek.nayak@amd.com>
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
	"Borislav Petkov" <bp@alien8.de>,
	"Dave Hansen" <dave.hansen@linux.intel.com>, "x86" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	"Peter Zijlstra" <peterz@infradead.org>,
	"Sohil Mehta" <sohil.mehta@intel.com>,
	"Brian Gerst" <brgerst@gmail.com>,
	"Patryk Wlazlyn" <patryk.wlazlyn@linux.intel.com>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"Madhavan Srinivasan" <maddy@linux.ibm.com>,
	"Michael Ellerman" <mpe@ellerman.id.au>,
	"Nicholas Piggin" <npiggin@gmail.com>,
	"Christophe Leroy" <christophe.leroy@csgroup.eu>,
	"Heiko Carstens" <hca@linux.ibm.com>,
	"Vasily Gorbik" <gor@linux.ibm.com>,
	"Alexander Gordeev" <agordeev@linux.ibm.com>,
	"Christian Borntraeger" <borntraeger@linux.ibm.com>,
	"Sven Schnelle" <svens@linux.ibm.com>,
	"Juri Lelli" <juri.lelli@redhat.com>,
	"Vincent Guittot" <vincent.guittot@linaro.org>,
	"Dietmar Eggemann" <dietmar.eggemann@arm.com>,
	"Steven Rostedt" <rostedt@goodmis.org>,
	"Ben Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>,
	"Valentin Schneider" <vschneid@redhat.com>,
	=?UTF-8?Q?=22Thomas_Wei=C3=9Fschuh=22?= <thomas.weissschuh@linutronix.de>,
	"Bibo Mao" <maobibo@loongson.cn>,
	"Li Chen" <chenl311@chinatelecom.cn>,
	"Huacai Chen" <chenhuacai@kernel.org>,
	"Tobias Huschle" <huschle@linux.ibm.com>,
	"Mete Durlu" <meted@linux.ibm.com>,
	"Joel Granados" <joel.granados@kernel.org>,
	"Guo Weikang" <guoweikang.kernel@gmail.com>,
	"Swapnil Sapkal" <swapnil.sapkal@amd.com>,
	"linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>,
	"linux-s390" <linux-s390@vger.kernel.org>
Message-ID: <197f6df0342.5b351ed5512924.4548698833385126603@linux.beauty>
In-Reply-To: <f391491d-f886-4579-9b40-78a57f2ed1b5@amd.com>
References: <20250706030636.397197-1-me@linux.beauty>
 <20250706030636.397197-2-me@linux.beauty> <f391491d-f886-4579-9b40-78a57f2ed1b5@amd.com>
Subject: Re: [PATCH v4 1/4] smpboot: introduce SDTL() helper to tidy sched
 topology setup
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi K,

Thanks for your reviews and test! I have addressed all issues in v5:
https://www.spinics.net/lists/kernel/msg5761848.html

 ---- On Mon, 07 Jul 2025 13:33:53 +0800  K Prateek Nayak <kprateek.nayak@a=
md.com> wrote ---=20
 > Hello Li,
 >=20
 > Apart from few comments inline below, feel free to include:
 >=20
 > Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
 >=20
 > for the entire series.
 >=20
 > On 7/6/2025 8:36 AM, Li Chen wrote:
 > > diff --git a/include/linux/sched/topology.h b/include/linux/sched/topo=
logy.h
 > > index 198bb5cc1774b..0b53e372c445c 100644
 > > --- a/include/linux/sched/topology.h
 > > +++ b/include/linux/sched/topology.h
 > > @@ -197,9 +197,9 @@ struct sched_domain_topology_level {
 > >  extern void __init set_sched_topology(struct sched_domain_topology_le=
vel *tl);
 > >  extern void sched_update_asym_prefer_cpu(int cpu, int old_prio, int n=
ew_prio);
 > > =20
 > > -
 > > -# define SD_INIT_NAME(type)        .name =3D #type
 > > -
 > > +#define SDTL(maskfn, flagsfn, dname) \
 > > +    ((struct sched_domain_topology_level) \
 > > +        { .mask =3D maskfn, .sd_flags =3D flagsfn, .name =3D #dname, =
.numa_level =3D 0 })
 >=20
 > I prefer the following alignment:
 >=20
 > #define SDTL(maskfn, flagsfn, dname) ((struct sched_domain_topology_leve=
l) \
 >     { .mask =3D maskfn, .sd_flags =3D flagsfn, .name =3D #dname })
 >=20
 > instead of having 3 lines. "numa_level" is 0 by default so I don't think
 > we need to explicitly specify it again.
 >=20
 > Also perhaps the macro can be named "SDTL_INIT()" to keep consistent
 > with the naming convention.
 >=20
 > >  #else /* CONFIG_SMP */
 >=20
 > A bunch of the CONFIG_SMP related ifdeffry is being removed for the
 > next cycle. You can perhaps rebase the series on top of the tip tree
 > (git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git)
 >=20
 > > =20
 > >  struct sched_domain_attr;
 >=20
 > [..snip..]
 >=20
 > > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
 > > index b958fe48e0205..e6ec65ae4b75d 100644
 > > --- a/kernel/sched/topology.c
 > > +++ b/kernel/sched/topology.c
 > > @@ -2025,7 +2021,7 @@ void sched_init_numa(int offline_node)
 > >              .sd_flags =3D cpu_numa_flags,
 > >              .flags =3D SDTL_OVERLAP,
 > >              .numa_level =3D j,
 > > -            SD_INIT_NAME(NUMA)
 > > +            .name =3D "NUMA",
 >=20
 > This can use SDTL() macro too. Just explicitly set "tl[i].numa_level" to
 > "j" after.
 >=20
 > >          };
 > >      }
 > > =20
 >=20
 > --=20
 > Thanks and Regards,
 > Prateek
 >=20
 >=20
Regards,

Li=E2=80=8B

