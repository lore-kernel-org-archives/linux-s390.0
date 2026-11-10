Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280563;
	b=PUeSIhIUzYDIpcJXJsDDe+P8Qwro12gAy3H5QEtEKuJtxIb0gLw1n36ovV3xHsJItMED
	 HqSDq7HUtpamXtI28c+JvXbBj2JJK1g+FmKkwFYmSC9zZV6GWR21Q3Tom+ncYS1YLVE2P
	 a9DrxvWpiM/9fdLMI9IE4bqb7O7lfFPOrAJ/EV1r1Jp1Hg1keDc5lz+MqnBBoLZKveT0x
	 z62ucZn+7kb5XqN5cTyv3mARYb6dwpwiDkW13j1HgKcpr48nsJI9J7K81aglF5aHE95nD
	 PW0OSupw47kJAyqexJ3LjHyIxBAkjSTJz0Fysy3tqKywpupjt6IGmTqqsDWJNjoLarQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280563;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=tKM22T/D5/SO/MGy5jLdaGL7gHjLOi5ZLHchOauKsAg=;
	b=Xg9olB6fHS0BWwRuAK5OR/4bxq3LNDlWgcAxYRnbH/w40isd7BPrDRWr6L7m+lqn5hSw
	 I5sOaTv8vNbRReIqvIQJ/NbsLARBzjRNndMYzCYABb5/bF5o+kRpeio95REQrl4zKpMmv
	 Or9X2NiNAjc2PQPBxt1vMkMskwQhwmLjXm4sSUtR0Gmh5Azvuv6SmvXRFzt3U5tCEE4rD
	 T2YdzjhOusGS01aZV3/X16e99Ts8HacjqmlvTh260GS8wojrRbx6wWBATgldcJ35DPR1i
	 s6Tf0q9dRPcnhUF0qh16tGUMsu2AVuUiZDTf2O0Aq0ITjYYg+FIHBBYCXT0UnpQp2lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=grdncc.com;
	spf=pass smtp.mailfrom=grdncc.com;
	dkim=pass header.d=grdncc.com header.i=@grdncc.com header.a=rsa-sha256 header.s=google header.b=NwxIXfIf;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD64606A330
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 03:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAD64606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grdncc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grdncc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=grdncc.com header.i=@grdncc.com header.a=rsa-sha256 header.s=google header.b=NwxIXfIf
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b147e06befso712925a91.2
        for <linux-s390@vger.kernel.org>; Mon, 09 Nov 2026 19:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grdncc.com; s=google; t=1794280557; x=1794885357; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tKM22T/D5/SO/MGy5jLdaGL7gHjLOi5ZLHchOauKsAg=;
        b=NwxIXfIfED92rj+yFVekhg0PoPvL6YqEIV+8UuPTeCTSJGMCqEVq7hIJ+SflQ/2qz9
         BYV5y3QxZYan/+H9wX4hQnSGdVMybN8ZiGD67y/3gVq0JI/MbBdn6EyqiPRNpSNmG66T
         p5BcQfDjmSFz6UPCTao36rT920jDVb1XwPgkG0GK59HFH+eAqz3PZrtF35lvRKFfTqzE
         Iq34Xg54uBrv2zbo+xSnFkrFcsRvDvdiaLNdc2RS/+e455QrfsSbx3CWYH657zWiUoM4
         z2GWIDCs8gooGGJOV0rqY9f+xuZbR5SbxV3OJvRI9PJZGkA3neqqFc1oCTfcajQFow1Z
         WLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794280557; x=1794885357;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tKM22T/D5/SO/MGy5jLdaGL7gHjLOi5ZLHchOauKsAg=;
        b=Xfnq4c6cefChWGGQx4YHq1WBLhlS+Ea36xO21B6O5HjripTxj/G05TMC/LL+Fe8PvY
         T4Vj7875SXgAklIRFUD4RNS0muYFvsLvuQTKuG2hz2ldSJwbFqegik0PvYLING/apu9w
         g1/0Mj7AX2FlMgY9P1GR3dMzIupeo5sqJs/EDNiojdi8cUd2g/GODJPrcinZuUanM57y
         n1Sdr3DDrZZ84SiVK4i/WbwD7eAWBmd0+JLYSjqDgo4da2b94EUTlfeg/6RmdUajjAfa
         uw5IuvoWAbT/zxqiK9hU/9hYUAphVhUzNOvrYq9UNc0BFlWJykD9RdwPNEyfIw5ya2tm
         tEGA==
X-Forwarded-Encrypted: i=1; AL+hErGINHNzM8epXqbS4vwnenQDd8TC3UJpxl61WCX2yWXlroPuvh4b6om4HY41bsdpp1rBrtwJ6Rz2nfC2@vger.kernel.org
X-Gm-Message-State: APuU4Z9zWtNZpiriW77oL5uTOZszoXuhdILnSKpFah7y5XMd7dueotBx
	GLYAuqXD9SosD4hdOcqcme2WRO52IgLc+lQMms3vhM+txlll2AeXZQZRjD/EdBA/HnRgxF3Og7Z
	hNyx3/dM=
X-Gm-Gg: AYBFou3TZVtYv1nirWozjuKGIVQrBgn6IiMrtVBZ0BmzA0QcEBNDl6ie4bzHmDVgcgJ
	uQE/Ac6yCXmxUczUBmz8P5m43w81R4jsn6yTgCEOVlFCCgcKRuo97M4RAG5sDInRzu27PzdDjbE
	SkOyieVg+eQmPlFEbO1T/RcHptpYXCW7EIn3yYzq9ifKwtxx1CBuNxt5BV66jp8vfxZtNxY5kKK
	ylbXGQlC1dEoIP+P6/zg3gzsUJq89lIbWT4reDCNmC8UORsX/jxBVOzb+KB68N0mSRxJzxVMA+c
	vmzCiZqnh7nG33bmGYjdk8/Uag4FwPXtzsOdmqXQJFLGkb+xRt3cfjL3W6jCfl9QJJ+Z1JmXCnS
	+tkXaSbQOYPL4fQIi8zPNeou9ivANs/eSAgZVNaXaPPeKCIAgu47g0yAISwbNDsEBpPVaLV1cxQ
	FeAPQqVA5o+wHBocI/7asBILMMo3oTZIJorIXAO9eHrWr2E6sX7GRF3lLKeeFogA5tb9pE/ZzGI
	5SqRdkgj8YbXzJ3pg/N9abWeLBnvunZ8nMimx7/n6jdbka2sl9lhVeHMIqqwqTuakRPa4fFwbb5
	uBJ0eEm/9FsGxW3moBp/IvAhJqdi1LAvwjNw6TLY6PxSoKej+qzMoFRiZ4JnOKXbaagd09PDZW3
	/ZkZZJvKH4Ji+cZEJY/p/6XMeei+DX+4a0w==
X-Received: by 2002:a17:90a:e7d2:b0:3ab:c80:9365 with SMTP id 98e67ed59e1d1-3b166d11497mr1560555a91.42.1794280556688;
        Mon, 09 Nov 2026 19:15:56 -0800 (PST)
Received: from smtpclient.apple ([103.243.98.37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b16797069bsm1826210a91.14.2026.11.09.19.15.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2026 19:15:56 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.3\))
Subject: Re: [PATCH 0/6] sched: Expose writable interface for preferred CPUs
 mask
From: Maxim Kuvyrkov <maxim.kuvyrkov@grdncc.com>
In-Reply-To: <20261101192203.6979-1-ynorov@nvidia.com>
Date: Tue, 10 Nov 2026 16:15:31 +1300
Cc: Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Yury Norov <yury.norov@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Andrea Righi <arighi@nvidia.com>,
 Ben Segall <bsegall@google.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heiko Carstens <hca@linux.ibm.com>,
 Johan Hovold <johan@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Mel Gorman <mgorman@suse.de>,
 Mete Durlu <meted@linux.ibm.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sven Schnelle <svens@linux.ibm.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org,
 driver-core@lists.linux.dev,
 linux-s390@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A2B09626-39F0-4EC3-B57D-CD83D77DD208@grdncc.com>
References: <20261101192203.6979-1-ynorov@nvidia.com>
To: Yury Norov <ynorov@nvidia.com>
X-Mailer: Apple Mail (2.3864.700.51.1.3)

> On Nov 2, 2026, at 08:21, Yury Norov <ynorov@nvidia.com> wrote:
>=20
> The preferred CPU mask currently lets the steal governor reduce vCPU
> demand when physical CPUs are contended. This series adds manual =
control,
> opening more use cases.
>=20
> For example, setting CPUs aside for selected fair tasks at runtime =
while
> steering other fair tasks toward the remaining CPUs.

Hi Yury,

I've been trying to do this with crutches in user-space for a long time. =
 Thanks for implementing this in the kernel, and with a convenient user =
interface.

>=20
> A user can mark a CPU non-preferred and pin a workload to it. Fair =
tasks
> whose affinity includes preferred CPUs are steered away, while tasks
> whose allowed CPUs contain no preferred CPU can still run there. The =
CPU
> stays online, task affinity is preserved, and the selection can be
> reversed without rebooting:
>=20
>    # rmmod steal_governor
>    # echo 0 > /sys/devices/system/cpu/cpu3/preferred
>    # taskset -c 3 ./my_workload
>    # echo 1 > /sys/devices/system/cpu/cpu3/preferred

My use-case (being a compiler optimization engineer) is to pin =
benchmarks to specific cores, and stop the system from using those cores =
even when the cores are idle.  This prevents L1/L2 cache pollution and =
makes performance numbers more stable.

Thanks!

--
Maxim Kuvyrkov
Garden City Compilers

