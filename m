Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794427949;
	b=wiRRF1XDsOGBgJLa36MpnSDBnzIWPVV/Fye+RZcOLskqor/doj608u9zaoK2HyntUh8T
	 N3X6mVg0V3mqY4nJsjBUhcZc+Zv7Qn+O9mVkyQQBckaDWcJXWTuUtMicPOmI+huDEl+JA
	 sZODwQWaV8D6BxWoYJk7Y6QoEEHpx50FvRMmBDDYj26mCUbrR88fuHw80pYlNTsmqEPg3
	 rkT6/stBsTPUtJBj/lkk1IWD3mqlnNgkv8RRrJicbPFmqBI2Q1dTpygupuXhCuziru0MD
	 XEsedPpCM3Ni4ykawdGjCxXPjabs4jQaH9FQgm8ulgNNmcamPzNl+SuZi2h7KPHhsLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427949;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/S8pzNgi1aLIkjcnLAAOpZIsZWtQWdqJ9nJA+Jb1dDk=;
	b=p4XwpFMiLlPp5r+9O6RSoL2got4MFBh/pGQ2PJex4HND+vLLQ7OWYQPjJGMYnIPvKOrQ
	 E/AILmEWJnI6PpUBjwRqTGERLcwcZeyKB9zWfE5PYV79kMC6V69I26UldSdlppaN+f9Cf
	 hpPKDiRrywvceorO4kpLmU8ksCM+8g38/JDwEQIgUMii8XJgertOwoVQ8kzTRPJesjsmR
	 srwb9NBzmj1JoSJ/Qs4ndTgXYwid0FekjcFOjGf5aPI8epGR1diAAkcw4rRYsQwN7iQ89
	 mczb937zKnldllqn0Rc7Oki+Nu3Ic0l0scnfgWcA6ifyPbwCONlmu/sItS/VbOzWh0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wo3YnZ06;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F47606A324
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 20:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wo3YnZ06
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1ED1F00A05;
	Wed, 11 Nov 2026 20:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794427949;
	bh=/S8pzNgi1aLIkjcnLAAOpZIsZWtQWdqJ9nJA+Jb1dDk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wo3YnZ06uWRU0dWy1huCh1XZ44brBY2cdVVbhpGrG+/8lwRE3/61ZvZWtJiNEGEMw
	 d9qLp/XqThG94+SEqofMEpfZDJ3JmqgHQMrlelhDZclex/Ond4dJqaBuB+vMY3A0ca
	 HxrxQ+4zYJYtXgqcq3NElRmb3VTl0COQy1MPI4hhcz5N+6/Eujb6YtS8UE437Dt5DF
	 YdrrUbGaGmCR5VmsGHa3ZnWbnDAYnLLufHWqGFi+YLvdMq8r85iv+XEd2TeHEYfjMM
	 GG2nnEpE4QBMQ0t4ZXDcDt/IrqlIiHTcLlJmE2IdFdUy+/S1RSo3sbWn0a4ONgQ78c
	 igu1wD8agv5sQ==
Message-ID: <sashiko-outbox-209620@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 06/14] s390/vfio-ap: Transition guest migration
 state from STOP to STOP_COPY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261111192308.2585984-7-akrowiak@linux.ibm.com>
References: <20261111192308.2585984-1-akrowiak@linux.ibm.com>
 <20261111192308.2585984-7-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:12:24 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

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

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111192308.2585=
984-1-akrowiak@linux.ibm.com?part=3D6

