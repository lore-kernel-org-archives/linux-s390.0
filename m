Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD8A3F88BE;
	Fri,  7 Aug 2026 22:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786142626; cv=none; b=qA6lWT3XLEMLJzzJ84t10nBlrcStRcKRdGAEgoaw9blm1il3DxxLGVD7g6rqjfNCwoDQMaY+CQK7IgnnNir9CU2yT0q6yq+fIXTaVuzebFXfWEpBPy93K9UmQP6uHwF/lMrtTlpvBlmWNgLDnPriD6kDUecruwFeCj+pmCMyISk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786142626; c=relaxed/simple;
	bh=HncIakxeYXFuIQ1uL65qm14QWjtEO8ShDaIx3z6F7Tk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VzxGGoOkVyEHSmf3lwis5WMrOsMAZJ+VFbEsYaApuTpHa6YeMZbSoa16X2rNALbyX7o1zvtHkVtzJXiMT48ORf0pEcK5fA4Km/QMu+lrdhCs41affzzU2VixT2djHOdN/9BImlWWQAzAmIs88sM3vwJ+k8i1MrXAMJIM2l5Ywd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIG66jXz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIG66jXz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E851F000E9;
	Fri,  7 Aug 2026 22:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786142625;
	bh=HncIakxeYXFuIQ1uL65qm14QWjtEO8ShDaIx3z6F7Tk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JIG66jXzPyC3LiRLOGJOrI7/TNqhsnIqcA60fnCoR4ZfX3uij0gGxLY1lyLi2Ao4R
	 b3BzhpMXdN6KDkhx7m8kbHZFCsmvan3ARS246sFmQRTy/P3qJW5DmPM+63xc+O68jp
	 OmEIVqakVwLDY7+9akTwtR/I6rjU6FtHhye3RcTsZQBhfNWDdoDCMDzw9XwlhZg9CR
	 kMrdWT10Q879koUn1iOw58v1cGO5Qy9TLC296ymxNrw0rxPVq5p6IffoxgTmlbsoOD
	 37WmOWWKlSGkztEi8pFgc1vLbo7tNFRNPuBemOvhXU/vTMhv6sm+00Eci/KF/tJFnB
	 SgzM5I74mdNVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/15] s390/vfio-ap: Transition guest migration state
 from STOP to STOP_COPY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260807221834.562851-7-akrowiak@linux.ibm.com>
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-7-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 22:43:44 +0000
Message-Id: <20260807224345.40E851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The transition of the guest migration state from VFIO_DEVICE_STATE_STOP to
> VFIO_DEVICE_STATE_STOP_COPY begins the process of saving the
> vfio device state. The vfio device state is comprised of the guest's
> AP configuration which specifies the adapters, domains and control
> domains to which the guest will be given access.
>=20
> To begin the process of saving the vfio device state, the VFIO AP device
> driver opens a file stream that will be used to read the source guest's
> AP configuration.
>=20
> Note:
> This commit introduces the file operations structure for migration state
> files with a stub implementation of the read operation. The complete
> implementation is provided in the subsequent commit.
>=20
> This incremental approach allows for easier review of the migration
> infrastructure setup separate from the actual implementation logic.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807221834.5628=
51-1-akrowiak@linux.ibm.com?part=3D6

