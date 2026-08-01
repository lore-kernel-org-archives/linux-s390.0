Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F1E30566C
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785608514; cv=none; b=cz8leKHBUEdWe8zRMMMV2sWAfuWzmSbd89Pzn+JbmHa+CzA5nzn/Q19n1jFEKbCI3sSsCDZh0tfPeTLATTQdQ0XdPA2D0bnz+nlp9fdcauVrUGxQ3n4n3dUWKadG5jEa2LlNYkXljPwR4QKHK0SxJYi4y3C0pZlx52AKt/4oMcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785608514; c=relaxed/simple;
	bh=ZgkcYw+Gxnywz0jIAxgD0qopqJBRSntNtwo6URtbU5s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WGAPTCXJEc1s9ynotcZAl/cxqAUtqkDAvobehWRoU5P1v8BOJkW7Hrd5HnMmn+qpgechdIEtXIMoFufd0FqeKsk3Oz1Ns2vRSYFUo4MkCDiU1f5XDzjWHyjCBVFz85s1obbGsQDzqAiKuHs/9/ZzlCe6qPShRmfZSriki9PAdfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcMxqAQ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcMxqAQ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362F61F00AC4;
	Sat,  1 Aug 2026 18:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785608513;
	bh=g828i5OtnqkcZXu7X6rlWs9Tv7vRmbX6u0xmEOr0bFo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GcMxqAQ+Cqd/x/opTmPi080OMfL3waJBd8yWhSQ6oXovijRIDOj/Q6yxm6L7B5emn
	 SNCQTlq5RnpB8NRsVbbRhXzEks78pazXmonripbA8BO8qndI3Ji47z13cWPyfNBJ/P
	 NyEb+UpZvYlfmK1eEHDbXxsUaDr0YQ9Pnbc6CnirRD+RFNA5XYYudc1cCJhBJ8BKzH
	 zwPaF5/BGm4KX10ZJwVBfbGZuNOQMgJVbKqAQUsL76oXEAZeA/I2OaODN4zCKXKK83
	 Gs0cbenYUdiX4FKbeOXy+vtvFZEnQgfWkiEiPcBvBhDPdhSXfZv5PfRnhezZswt1KC
	 cPiEheJnexHvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/19] s390/dasd: Propagate partial completion length
 across ERP recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260801180033.3679412-3-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
 <20260801180033.3679412-3-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 18:21:52 +0000
Message-Id: <20260801182153.362F61F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] dasd_eckd_ese_read() directly dereferences cqr->callback_data,=
 which is NULL for ERP requests, causing a kernel panic.
--

--- Patch [2]: [PATCH v7 02/19] s390/dasd: Propagate partial completion len=
gth across ERP recovery ---
commit 5cfd110150006620d9ee9acaf83c89fea865281b
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Propagate partial completion length across ERP recovery

This commit ensures that the partial completion length of a request is prop=
erly
carried over during error recovery procedure (ERP) post-actions. It address=
es
an issue where partially completed requests would silently return zeroed da=
ta
because the processed bytes counter was dropped.

> dasd_default_erp_postaction() copies the timing and device state from
> the finished ERP request back to the original request but drops
> proc_bytes. A request that was partially completed, an ESE read of a
> not-yet-allocated track returns fewer bytes than requested, and then
> recovered through the ERP chain loses its partial-completion length.

[Severity: Critical]
This is a pre-existing issue, but since we are looking at ESE reads recover=
ed
through the ERP chain, does the current error handling sequence lead to a N=
ULL
pointer dereference?

When an ERP request encounters a No Record Found (NRF) error while reading
from an unallocated track, dasd_int_handler() processes it. While it uses
dasd_get_callback_data() to check the data direction, it appears to pass the
raw ERP request to ese_read():

drivers/s390/block/dasd.c:dasd_int_handler() {
    ...
    if (device->discipline->ese_read(cqr, irb))
    ...
}

Inside dasd_eckd_ese_read(), the code directly casts cqr->callback_data
instead of using the helper:

drivers/s390/block/dasd_eckd.c:dasd_eckd_ese_read() {
    ...
    req =3D (struct request *) cqr->callback_data;
    ...
    first_trk =3D first_blk =3D blk_rq_pos(req) >> block->s2b_shift;
    ...
}

Since ERP requests allocated via dasd_alloc_erp_request() do not set
callback_data, req becomes NULL and is immediately dereferenced by
blk_rq_pos(). Could this cause a kernel panic, and should dasd_eckd_ese_rea=
d()
be updated to use dasd_get_callback_data(cqr) instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801180033.3679=
412-1-sth@linux.ibm.com?part=3D2
