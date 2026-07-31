Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A2844C4F8
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514585; cv=none; b=hssrPASp2UyGCgoBgTyTWC78akPhkvSDIbD5xQdPD44I4F0N17CQTtANttCUAaCyX/kg/rmeL/2o47Rmz9myR6m5A+X+kjiGeMVZUXfnI2uARNQkIZ14dfbpl0rlLH7qne/M3K/MpocMn8wYaG74MqBUxnX3+dLYFsDoojRVaIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514585; c=relaxed/simple;
	bh=St5APSqOu7vkfiF2HMWU4v0ht7R75hZSLZPpvO+Aa9M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KBQlUGUk3lN2O85cORGpp5LUiL2weBGS5gq3HSlnkJtLILQLerB9b1MC+iJOAG055tkWz4H8s6S+DxMOtc14lsW/jE8PNWs8TvlhFyb5aScpoOOswRL9WTO7XHpPar3B+Ty96PqA+i+Ffqwynnqdaq6JMbBRaE94qpu+rNG7/QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJF9qBoP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJF9qBoP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8656F1F00AC4;
	Fri, 31 Jul 2026 16:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785514572;
	bh=WAG7MHCiU5ZnEESivQw29nppczBM1yGuNIa4RTh3Y50=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KJF9qBoP6U4/qTt7OkP9ktc/aCHTD4rVWShPh6nVRMS6FgqwXiYJEd0FMl0HpEOFy
	 4fb5C3ltgvCRcygxp37kSRO4zhGJh4avlq+3N5GNFivS3UFekhmkmi6GU9xtQkGIbh
	 ylcR/IilkYdlYAWYC8nO9ohb+LqThhMka0b0VzTA15mTYpHpt53/vDcg2e8qFjLzjN
	 VzG8OxFHo2BT58v57mIf8EtM8cPkwAVKgEnVjlLKyorcn211K0n+lQiKf70sYuj4Gm
	 jVlD+RoJY8jXKtabec6CAn3j/LOSYXFmWv3/WU6hACrgq+0VKeDW7xnnuEd1/V2ls8
	 yirnGOC63Xuzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/17] s390/dasd: Add infrastructure for ESE
 full-track write
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260731153842.1729627-7-sth@linux.ibm.com>
References: <20260731153842.1729627-1-sth@linux.ibm.com>
 <20260731153842.1729627-7-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 16:16:10 +0000
Message-Id: <20260731161611.8656F1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Aborted origin CQRs (DASD_CQR_ABORTED) are erroneously completed t=
o the block layer with an I/O error or requeued, causing double-completion =
or use-after-free.
--

--- Patch [6]: [PATCH v5 06/17] s390/dasd: Add infrastructure for ESE full-=
track write ---
commit 6ca5a3ba40b43e7a20a1f06beb37ce4d8e6866d8
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Add infrastructure for ESE full-track write

This commit adds driver internals to build WRITE_FULL_TRACK FCX channel
programs for unformatted tracks on ESE devices. It introduces new CQR states
(DASD_CQR_ABORT and DASD_CQR_ABORTED) intended to retire the origin CQR of a
replaced write without completing it to the block layer. It also expands
the CCW and ESE format pools to keep maximum-size requests in flight.

> diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
> index 3658a714abd62..d6ccf0186ada4 100644
> --- a/drivers/s390/block/dasd.c
> +++ b/drivers/s390/block/dasd.c
[ ... ]
> @@ -2759,7 +2804,8 @@ static void __dasd_process_block_ccw_queue(struct d=
asd_block *block,
>  		if (cqr->status !=3D DASD_CQR_DONE &&
>  		    cqr->status !=3D DASD_CQR_FAILED &&
>  		    cqr->status !=3D DASD_CQR_NEED_ERP &&
> -		    cqr->status !=3D DASD_CQR_TERMINATED)
> +		    cqr->status !=3D DASD_CQR_TERMINATED &&
> +		    cqr->status !=3D DASD_CQR_ABORTED)
>  			continue;

[Severity: High]
Will this cause aborted origin CQRs to be erroneously completed to the block
layer?

By allowing DASD_CQR_ABORTED to pass through here, the request is moved to
final_queue at the end of __dasd_process_block_ccw_queue().

Later in dasd_block_tasklet(), all requests in final_queue are unconditiona=
lly
passed to __dasd_cleanup_cqr():

dasd_block_tasklet() {
    ...
    list_for_each_safe(l, n, &final_queue) {
        cqr =3D list_entry(l, struct dasd_ccw_req, blocklist);
        ...
        __dasd_cleanup_cqr(cqr);
        ...
    }
}

Since __dasd_cleanup_cqr() lacks a specific check for DASD_CQR_ABORTED, it
will set the error to BLK_STS_IOERR and complete the request:

__dasd_cleanup_cqr() {
    ...
    status =3D cqr->block->base->discipline->free_cp(cqr, req);
    ...
    else if (status =3D=3D 0) {
        switch (cqr->intrc) {
        ...
        default:
            error =3D BLK_STS_IOERR;
            break;
        }
    }

    if (error)
        blk_mq_end_request(req, error);
}

If the replacement format-CQR also attempts to complete or requeue this
same block request, could this lead to a double-completion or a
use-after-free in the block layer?

As a related question, does dasd_generic_requeue_all_requests() also need
to check if the CQR was aborted? It currently appears to requeue the block
request without checking for the aborted status:

dasd_generic_requeue_all_requests() {
    ...
    _dasd_requeue_request(cqr);
    list_del_init(&cqr->blocklist);
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731153842.1729=
627-1-sth@linux.ibm.com?part=3D6
