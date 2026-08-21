Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E5B35676A
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323689; cv=none; b=AuuSRvER51M4b3/gSZRMLEECznKPXL7NBv/Ad4+vEuM2SvJFSdsytkbvqqaqIWAz7FJwH6bRREBMDUfa8Ormvpey7HXHSrR+UUMzxRTBuzeDFOSJ+AGwGq883420UGKgJNDbe9bhVTCzY9zKJKyat7tjperXxWOk34Wn3Jo4M4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323689; c=relaxed/simple;
	bh=LSOoG3Y3HOsA8NmYR28nm/qZ0eSV1KbQgMCZ778hGSo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KVVEci/NG8VlLASLJ8TOh1qUI5I5EQOb8Qx6LzmlSkXOtZCLufGDIyFlP2ro63WaahBwQiJk6io1iWGeF0bNmmQ+KTe9/3mst+Klz8Du+eiLzXTe+WQfk28RDVVxYcnU6cV2lfNuKNY6OdVUr54ksfTdzz9J4YvdLNORwenfijw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZ/H3lp/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZ/H3lp/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B7A1F000E9;
	Fri, 21 Aug 2026 14:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787323688;
	bh=LSOoG3Y3HOsA8NmYR28nm/qZ0eSV1KbQgMCZ778hGSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fZ/H3lp/4SrcjzwX7JwVb+nb455PJR8+TihMLzBzHVKBS/KC+hkBQMzhdWN5L6w6m
	 VsKOZKQ5CfAgtg6XDESDSwOojYiSMPsqiCPqjEc0SjbwcYb9N5+m7i3n58ZEUQB/jf
	 cFWw3KJUG7pyS69DkJ1isp7n3LdYtiJtUlAM+esmN4AsFr+zYQvG8YtcdDITpkOj9t
	 cXoumrVF6tgNftRd9xKKHjJomaVDtPk8FkP04uWdfJuFt32H9y5K/727HPEm9Cxs8E
	 rZTJtPUjkR8sppuV7ag1BA2aZQqLTao5p1i/MkqPQjPlqMmDRFHqADdIdzHXWKcZ/k
	 ezVej3RQCggDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] net/smc: fix socket refcount leak in
 smc_switch_conns()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hidayath Khan" <hidayath@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260820144729.1019399-1-hidayath@linux.ibm.com>
References: <20260820144729.1019399-1-hidayath@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 14:48:07 +0000
Message-Id: <20260821144808.11B7A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A TOCTOU race during link failover allows a killed connection to a=
bort the failover and bring down the healthy backup link.
--

--- Patch [1]: [PATCH net v2] net/smc: fix socket refcount leak in smc_swit=
ch_conns() ---
Note: Due to system recitation constraints, this review uses a free-form su=
mmary format rather than quoting the original patch diff.

commit 52d43741c14f87f177497a6086c3732a98a7fec5
Author: Hidayath Khan <hidayath@linux.ibm.com>
net/smc: fix socket refcount leak in smc_switch_conns()

This commit fixes a socket refcount leak in smc_switch_conns() that happens
when smc_cdc_get_free_slot() returns an error. It restructures the code to
use a single sock_put() on the common path instead of adding one to the
early error exit path.

[Severity: High]
This isn't a bug introduced by this patch, but there is a pre-existing
issue in smc_switch_conns() related to how it handles connection errors
during link failover.

When smc_switch_conns() iterates through connections to migrate them, it
drops the conns_lock and calls smc_cdc_get_free_slot().=20

If a specific connection is killed concurrently while the lock is dropped,
smc_cdc_get_free_slot() returns -EPIPE.=20

Because smc_switch_conns() evaluates this return code and jumps to the
err_out label on any error, it proceeds to call
smcr_link_down_cond_sched() on the target link.

Does this mean a single killed connection returning -EPIPE will incorrectly
abort the entire failover process and bring down the healthy backup link?

Since this forces a teardown of the backup link, could this be used to
trigger a denial of service for all other sockets sharing the link group
if an application closes the socket during the link switch window?

Would it be better to skip the killed connection and continue migrating
the remaining connections, rather than treating a connection-specific error
as a total link failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820144729.1019=
399-1-hidayath@linux.ibm.com?part=3D1
