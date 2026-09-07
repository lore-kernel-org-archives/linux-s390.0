Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68924477FA
	for <linux-s390@vger.kernel.org>; Mon,  7 Sep 2026 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788777545; cv=none; b=RE3QX1f9rlpoNEnf6MtkzSmrEmpTdyY8crTYOWMDOrDG/udbqbMlwPtK7KWJ66k1H6J+8LNSpnpK2Jay1uGGlIRCVtIvqjAAGcPQd3tJIg/4JapOgCt9M6RmyqT5g4Fah9LeXG6yd7oeFOcHKvkf2AC5Ft2hU6QVC1Ie7GJKpLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788777545; c=relaxed/simple;
	bh=/rJj8K0Og4qarNxTO5xOeKV6XtKG+iSSxo14fwuVSMg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qsDNlHfhQtZlApKU9qpz0SleUmGL8VW4ekvdZ/od5NOoblzTCJFm73NN4w22uqn7sE6zjPegLfjPZZZ5vFHc/GlksuFFwdeakH1eDGDtM8yzm43PhcsX/5bqY03Sb309eiZ8Dxy8OVqcSEm0kdaWh6NRuEuCu4u/SGuyUp6O1Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZuJniO6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZuJniO6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CF51F00A3A;
	Mon,  7 Sep 2026 10:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788777543;
	bh=B9zbe9kYT6sp3T4Le1ygjWlm9QGI8aT0JbxXuLf28ZY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VZuJniO6x/fw/Cf67s26d37yK9C1a4S08+ZnnD/e4f6ThQ5HPOhY/u0K2/WbfMohI
	 pqxGNaUMPl+zoNXTV3H9mU+fLEgxISH79kM1M0UFXCW5zw8zViFDuXJThzb6ikSi3O
	 RUuhcUrDSSatTDD6LJR2OzX0yTOIwUqclQKlcpu3CvAYgCGknLFk2Foi0d7zN/eQY5
	 5hQthcqRr5dsveGiAeOtYA/t1TUuHfVxsy8Aq1BxfpvldvDsw44hc9kDIIN6Ngt0kK
	 S9fow4q3UqX3k/0kD1Mez97oCrlfIkSVV8ayJFb2IK/PQmnyW0o7oyfv1yItykxU0J
	 S0RH9tjS8B1ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/core: Allow list_del during perf_event_overflow()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Richter" <tmricht@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260907103219.3006700-1-tmricht@linux.ibm.com>
References: <20260907103219.3006700-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 10:39:02 +0000
Message-Id: <20260907103903.15CF51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> A PMU might use perf_sched_cb_inc() and perf_sched_cb_dec()
> interface to get the PMU call back function pmu::sched_task
> invoked at schedule in and schedule out. This is achieved
> by walking along the list anchored by sched_cb_list.
>=20
> The following scenario might lead to a list corruption.
>=20
>    perf_pmu_sched_task()
>       for_each_list_entry(..., &sched_cb_list)
>       +--> __perf_pmu_sched_task()
>            +--> event->pmu->sched_task())
>                 +--> PMU_push_sample()
>                      +--> perf_event_overflow()
>                           +--> __perf_event_overflow()
>                                +--> pmu->stop()
>                                     +--> perf_sched_cb_dec()
>                                          remove entry from sched_cb_list
>                                          while list node in use.
>=20
> This happens when ioctl(fd, PERF_EVENT_IOC_REFRESH, xxx) has been
> invoked and perf_event::event_limit hits zero.
>=20
> Prevent the list corruption and convert for_each_list_entry()
> to for_each_list_entry_safe().
>=20
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907103219.3006=
700-1-tmricht@linux.ibm.com?part=3D1

