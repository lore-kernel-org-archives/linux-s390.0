Received: from mail.vexlyvector.com (mail.vexlyvector.com [141.95.160.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65445D743
	for <linux-s390@vger.kernel.org>; Tue, 20 Feb 2024 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.95.160.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419048; cv=none; b=fhLEaRuxS+bCJTNFKIdZ4vv+ZjRX00JKSUib8rGoutr8vWKHGyWG8/9v6vYaNHhieTV+v8hJHCHzj9Y3rj2NtqcP558RPmOzFfB4QmzwtEix8MPlDQimJCWHLudK1yV0/qxUoBkGEAvtSpqcRiSwg/OyWGv2wwsMgObR+U+gajs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419048; c=relaxed/simple;
	bh=waaYxUsyRtmB2zEBuWcqRuRHSoYd8sJFCtgHO/3AHKE=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=ETaefWFC29PRdBdjW5A1Sj14iXpezNkoiks+rl7to6QJECE9BHyiNcoI44i9nKRYhJQq1bM6fPvKbM3hpdd4sLY4DbWofEmjkx5nVtadY/rEA6l/de5fnKBUrDDu0PHJypsnp24iysFYZ6M4Q6LTrwOoTFN62IRL2Y+KbYTfIYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vexlyvector.com; spf=pass smtp.mailfrom=vexlyvector.com; dkim=pass (2048-bit key) header.d=vexlyvector.com header.i=@vexlyvector.com header.b=ejFRLrjI; arc=none smtp.client-ip=141.95.160.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vexlyvector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vexlyvector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vexlyvector.com header.i=@vexlyvector.com header.b="ejFRLrjI"
Received: by mail.vexlyvector.com (Postfix, from userid 1002)
	id 60AE1A2D11; Tue, 20 Feb 2024 08:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vexlyvector.com;
	s=mail; t=1708419045;
	bh=waaYxUsyRtmB2zEBuWcqRuRHSoYd8sJFCtgHO/3AHKE=;
	h=Date:From:To:Subject:From;
	b=ejFRLrjIzhp1GPZdW1/xnWygovhXhbo9NZwWep17VcRTSzbRfCtze2HP+BourCrbj
	 oTl/Lpgq3e3wruIwMsSwOX+flKzFsVfCDCGavvSijwlqiF4fFD14LgD5abJTJ0y5Ui
	 iK21fu2OzoKBdDF/JO2VoKVY2m8/F4H+QSTE3TP46GlbW59yiXZ7c76LZdovDzHm/W
	 MVfu6ZD/0UwfRGovQPqg/TgeJZ88waT+dkqMAFNF0KGSFG3mvXqBDKZkHJfcDtoFln
	 tm939V329yagYrz0pK2ZgPObytFc1PO7bzP86ElEIBKFVpRTjrO1ir0vZGRYV5i2k7
	 B+vXQlcztNdMg==
Received: by mail.vexlyvector.com for <linux-s390@vger.kernel.org>; Tue, 20 Feb 2024 08:50:42 GMT
Message-ID: <20240220074500-0.1.c4.qd2f.0.mqb8vvcvpc@vexlyvector.com>
Date: Tue, 20 Feb 2024 08:50:42 GMT
From: "Ray Galt" <ray.galt@vexlyvector.com>
To: <linux-s390@vger.kernel.org>
Subject: Meeting with the Development Team
X-Mailer: mail.vexlyvector.com
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I would like to reach out to the decision-maker in the IT environment wit=
hin your company.

We are a well-established digital agency in the European market. Our solu=
tions eliminate the need to build and maintain in-house IT and programmin=
g departments, hire interface designers, or employ user experience specia=
lists.

We take responsibility for IT functions while simultaneously reducing the=
 costs of maintenance. We provide support that ensures access to high-qua=
lity specialists and continuous maintenance of efficient hardware and sof=
tware infrastructure.

Companies that thrive are those that leverage market opportunities faster=
 than their competitors. Guided by this principle, we support gaining a c=
ompetitive advantage by providing comprehensive IT support.

May I present what we can do for you?


Best regards
Ray Galt
