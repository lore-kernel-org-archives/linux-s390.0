Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC501E1C11;
	Sun, 14 Jun 2026 22:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781474712; cv=none; b=oS1U0tjs6RgoMVqaMWSgDAJHpnrFYHfQCUgg/XwaARuteRFyfwcjgg2wb58Ms50v02RQMhuvDcXPC8NhiWxMIZTnDgQP4j6EKwS4nAzqEyl8G/3SQ2d66eqxG3bYtjUJmZmKCf8UBlC3gkfTxoBHVIN+VPwGWLYvz4Ot3IWruGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781474712; c=relaxed/simple;
	bh=VBm9DnDHSTb4bfUmhcKZ1bi5Hx5Q5HFHlWxoQDzdEF0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ExUeimIxj+wzQk4QYGcRI+vfaVWYMv7RZvdFFM3YErEyYwjkfU7PQ01NCBwzfgnz3kzSi2SoSL/YJSwMeXioKAGeZySaCe5ZJtRIgVmSv2lRD9oCTnUffuuaryYwhV+05J0t3GmEsierrw/szarQtOSTY3VBZYtY6CqHhiayidU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UDGJl78Z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UDGJl78Z"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ELKCNM458433;
	Sun, 14 Jun 2026 22:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EYuXAF
	bo8+BBsKwXs9oxT+D/EgFTk0yvLKlZxnhUsY4=; b=UDGJl78Z137a53UlE9Vv7n
	P2Pn9RWyeTqWOVtk6Lww3N6B9tN9R2mk2BKM3va3t1YRQ+mIVJWp5GIzVCQ/H7kf
	3/3MIzLJOJ0GYB7YSH7GenacWi1pnzd7cRCdkafNOsocsQ/0/83CQvMODhrJaAKP
	nGO+uDZbE9SSK/f9LEep46IjGun9srFfkhpcvqQhZVt76HFD9DtUKAmSUnRxsjYo
	tV1zAFp/AAAtF/eJtYtvNdD9nkLblTGdrY0Yi742Mx7oRI4wV0HaBMeLs+w+QNmj
	2ycTZbDhw7wBgbBpgw3sWRawKTle8KEUCnxr+DExoHwBvXdnOu0Q595/kvruHfmA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1efwet4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 22:05:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65EM4ieQ003359;
	Sun, 14 Jun 2026 22:05:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eskrg3qam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 22:05:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65EM53Du43516274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Jun 2026 22:05:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B903B2005A;
	Sun, 14 Jun 2026 22:05:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16ECD2004E;
	Sun, 14 Jun 2026 22:05:03 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.111.26.108])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sun, 14 Jun 2026 22:05:02 +0000 (GMT)
Date: Mon, 15 Jun 2026 00:05:01 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev,
        "William Bezenah"
 <wbezenah@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org,
        Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH v1] s390/virtio_ccw: Also suppress -EINVAL on device
 detach
Message-ID: <20260615000501.627610c9.pasic@linux.ibm.com>
In-Reply-To: <20260612160511.1B5101F00A3D@smtp.kernel.org>
References: <20260612155407.199218-1-wbezenah@linux.ibm.com>
	<20260612160511.1B5101F00A3D@smtp.kernel.org>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDIzMiBTYWx0ZWRfXw7ockxRxEApK
 lrej/XZYX/qN6t3ThF/sVhH9XqV0FzdKqFL0UOYEfx5RjmtlM9dP3mFncMBMY5uTELeRhff4dUw
 4H4fzS52/NWMiElrlG0yl+uhrMP0CSM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDIzMiBTYWx0ZWRfX5wkVrEkYYvjf
 d7fBeLcm9+JhiGEKqChGXuQohe9Swc8szunCqrzfDbnO37WllyRAAtn8vn+R4EuRwDFRnoi9oPD
 ToRHMgkBaqns1T2j8vrTUzmC1j68PLSAdGaMefB0u6Zb2StW9rcNiALlfWSP/vLnN+8ZJ/BiH1w
 IMG2fwQfy7uJTgc0+9M7eR01ozoqzJ7oYOzcxlVk2J54qZ5ZVoo0sMvmm88o2658gbT1kl2bMnL
 848TJDRd75fvzdAu1eWe1fENQ+mn0SmkYdCVkhiw6twKTzpzCkb51muY001pS0NqneBOVgC6qUD
 vveEz0/sChL3v8zWkBqA05GsvzizS9IJnJgFyEoQdL2Hy/Sl1pWgn26g+teNt1TxsHFuQGMXrBv
 V9qyntFEqVWQ5BQXbOPzkWP0w84I9/p+IVZMvOki79rg2ATSJ9kRxfiaKMT6Bm+lu9LINDRafmE
 tIwGmi3ZilLqcysaUyA==
X-Proofpoint-GUID: ZN4yvgCE5jLeATZZgp5b7StzIW8Gu7gB
X-Authority-Analysis: v=2.4 cv=NuDhtcdJ c=1 sm=1 tr=0 ts=6a2f2594 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VuOb_12H9V4q57O5eRsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: ZN4yvgCE5jLeATZZgp5b7StzIW8Gu7gB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_05,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606140232

On Fri, 12 Jun 2026 16:05:10 +0000
sashiko-bot@kernel.org wrote:

> [Severity: Critical]
> This is a pre-existing issue, but does this if/else structure create a
> use-after-free risk during virtqueue deletion?
> 
> If ccw_io_helper() fails with an error other than -ENODEV or -EINVAL
> (for example, -EIO), the first branch executes and logs the warning, but
> the 'else if' branch is entirely skipped.
> 
> This means virtio_ccw_drop_indicators() is never called, failing to clear
> the virtqueue pointers in the shared airq_info->aiv array.
> 
> Because virtio_ccw_del_vqs() subsequently proceeds to free these virtqueues
> via vring_del_virtqueue(), the uncleared pointers in the shared airq_info
> will point to freed memory.
> 
> If an adapter interrupt arrives later for this leaked bit, could
> virtio_airq_handler() retrieve the dangling pointer and trigger a
> use-after-free by calling vring_interrupt() on the freed queue?

Looks like this could be more robust against scenarios where we fail
to execute the channel program that is supposed to deregister the
indicators from the device.

The key question here is, at what point, can we consider adpter
interruption and event notification quiesced. I will have to do some
reading on that, I'm afraid. 

To me, it looks like just setting the virtqueue pointers in
airq_info->aiv would not do the trick either, because I don't see
a corresponding null pointer check.

Regards,
Halil
