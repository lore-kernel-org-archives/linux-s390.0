Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87A744781A
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514266; cv=none; b=WNKOB8GjVidr3f4ZRUQqntiRIhrQYeuCKO1iGgHKKKOyVu0SERzKigiij2R2o0NqvnOvM7T8ZaC1a2TfBusJWKO9w5gb3q5Ty5xmlWdzbeEs4NJk0Z3oMc/ZSziMmp2cG3ZWGDq9eiVRYKUkE0JqKBsGMIjr4tI8tzRLJ8wZLn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514266; c=relaxed/simple;
	bh=MRUznlzEok98ZRFbv/MoNXEMmhn5xkg8yGukqZpQwlk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V1I57XTMuujlhBkNMDryCpo2xuzdpamiMTwYhBpIJh5E7/mQ4oGz4Zh5NvQqmjLVqwD2tkYyBmQzeN1ZGrrXGazMrkqax+Zx+HQzbkatbVIpZI+CvJ9Ktz2+Ixtuml8ESZFiQC+gLmQQSHKZOOQT/p9cY8/aBfCetxdDC1/mbCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAfbzoIP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAfbzoIP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA191F00ACA;
	Fri, 31 Jul 2026 16:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785514264;
	bh=MRUznlzEok98ZRFbv/MoNXEMmhn5xkg8yGukqZpQwlk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cAfbzoIP/u4mZIt+BC0aBU10JIM7NEdZOrqkiaIiKRHBt2JFCmWOXozNOOoInfPWW
	 jOcuk/b3dI2g9MhFBdXnx7x0DnyXfcDmuatFp7Pafj3LQavMgB5jENpf+ar5UaJlAE
	 DFAKrXM5MXmN7zetYvnXczIHlMCjDXEFqV3K1H2lqbrka98JaA6b0epW5shUIhXmt1
	 L685fFW1O5twcprsahlkbFBygMFUXKVQCprL/Hbuv335ysfzY6imlKeqgcOKM3K916
	 fWKAw1eXF+LADT6NUKT/CDhcjWen0i4zfG7PtPg/wHOKojAvKYebnmGdz9b2fewHEV
	 gpmkG6OXuvdVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/17] s390/dasd: Add range-based format-track
 collision detection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260731153842.1729627-8-sth@linux.ibm.com>
References: <20260731153842.1729627-1-sth@linux.ibm.com>
 <20260731153842.1729627-8-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 16:11:03 +0000
Message-Id: <20260731161103.CEA191F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Removal of the `trkcount` snapshot check before its replacemen=
t is fully active leaves a window for silent data corruption, breaking bise=
ctability.
--

--- Patch [7]: [PATCH v5 07/17] s390/dasd: Add range-based format-track col=
lision detection ---
commit 758cbeac7b7b1d21b34dd4da47443455ac60838a
Author: Stefan Haberland <sth@linux.ibm.com>
s390/dasd: Add range-based format-track collision detection

This commit replaces the single per-device format_entry slot with an
array of 16 slots to allow multiple in-flight format requests. It also
rewrites the collision detection to use a range-based overlap check
instead of the previous trkcount snapshot mechanism.

(Note: The standard diff-quoting format has been altered to a free-form
summary due to automated recitation restrictions. Original patch code is
not directly quoted.)

[Severity: Critical]
Does removing the trkcount snapshot before the new collision mechanism is
fully active leave a window for silent data corruption?

In dasd_start_IO() (in drivers/s390/block/dasd.c), the snapshot of the
block's trkcount was removed. Subsequently, in test_and_set_format_track()
(in drivers/s390/block/dasd_eckd.c), the check comparing the snapshot again=
st
the current trkcount was replaced by a check for the collision flag on the =
CQR.

However, the commit message notes that the new detection only becomes active
later in the series when format requests are routed through
dasd_return_cqr_cb(). Currently, the format CQRs are routed elsewhere, mean=
ing
the collision flag is dormant and never populated.

Can this sequence occur and lead to data loss?
If an IO request (Thread B) hits an unformatted track and enters ERP, and
concurrently another IO request (Thread A) formats the track, writes its
data, and completes. Thread B will not realize the track was formatted after
its IO originally started.

Because the trkcount check is completely removed and the collision flag is
still inactive in this intermediate commit, wouldn't Thread B proceed to
format the track again, effectively erasing Thread A's data?

Could this break bisectability by introducing a vulnerability before the fu=
ll
feature is wired up later in the series?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731153842.1729=
627-1-sth@linux.ibm.com?part=3D7
