Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B4B4156D0;
	Wed, 19 Aug 2026 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136683; cv=none; b=CLd0jfr4hjrlWGkYVtbr60Obd36rjoLVxhOlhArO02QTdRzaN4YP+x1Ugh+8Vy1NL4maFzfJL44jHJzpYKtFNhPfq8EurlZvQi9CCV4OvPlKmL77gOhsfquw1UYzw4lPY1qtJtXt0X4Ob+fHiV0+SHN7/1u0q4y5v+gtIrLOBTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136683; c=relaxed/simple;
	bh=D5fKHW1R7VMi/jLkHPUEwSyTOoM0aD4o25q5NuxdCLM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y9YeJH65iQg47UfmQQAU3PLkyd+XKkdIxz1tGAnto779UmAOxPGQj30yp5uSz5wzOzHltJj4tLKhxAuyWP1V7bYGD0c2ukT7gIf75jvWCc3pFRjYWw9+tbJqw3+6v9EorbpPBtbkQAki2VusWaWv5EpdsN5WBmnMl5qJi0zE1Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KN1lK0yb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KN1lK0yb"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JAVa842072871;
	Wed, 19 Aug 2026 10:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PSeHHW
	jZP5CqEtwyk6aeCte5rY3t4OHvEvCgZMVYQ/g=; b=KN1lK0ybKRLnXWmOqbNUnL
	AG3FWghKkFtD5w1YNyfEFsSr+6LEj4cS2U34G2pq98dJEhMhl57SRUXTInA3YYCJ
	0tdB0C0fxG+MUWmhYUDZbTQQZLCXyhQKe3zzjNO5fj23+ImJqi1lAOGL7Ty+te9N
	wHfEsZxxKgt8lgBgwu64PJ34cL2mN8Pzr2YoUuuGs5G+0Xj9e1tjX016CprC7Gbg
	EL7v8x6RZo3Y59JQUpltTKj6DVb5CERcb/rGZUI6nZ7xogxy2Jis8qkz1HhS1pQI
	35Wyan4N0Ga8WBAQGQ2VeJ6oM1JEh/rYVQxDdk8tvKYUTU877b+XlyYHsPgIzxlg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu233uc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 10:51:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JAfHde015261;
	Wed, 19 Aug 2026 10:51:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngg9fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 10:51:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JAp6O542009080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 10:51:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 747742004E;
	Wed, 19 Aug 2026 10:51:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADA7020040;
	Wed, 19 Aug 2026 10:51:05 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.87.134.55])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 19 Aug 2026 10:51:05 +0000 (GMT)
Date: Wed, 19 Aug 2026 12:51:03 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Anthony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, jjherne@linux.ibm.com, borntraeger@de.ibm.com,
        mjrosato@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, agordeev@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, stable@vger.kernel.org,
        Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH v6 1/1] s390/vfio-ap: fix KVM GISC and page leak when
 queue removed from host config
Message-ID: <20260819125103.252dd89b.pasic@linux.ibm.com>
In-Reply-To: <20260818193349.1877940-2-akrowiak@linux.ibm.com>
References: <20260818193349.1877940-1-akrowiak@linux.ibm.com>
	<20260818193349.1877940-2-akrowiak@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=AdqB2XXG c=1 sm=1 tr=0 ts=6a858a9f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=3vdy5-oN-KzRg_VM1_MA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: WwDsRbYs7LSdJPzSrQq8tAiga5pVr6pq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA4MCBTYWx0ZWRfX7xLqgHJi4gJ9
 S7n9xIvvnYdXvrRp775yhjF8a+Ebeqvms46b//kf3wudCJpkdBU1XPcSrCnmO65vjL9Ub7SK0V/
 w6LyycdKnN708Qnx0hqozcgKEYDXZ7xiuwtjmYYk6vI6Q7IvXWbs+BJMhQgpC9E6B5adiLrEnFS
 K/gwrE+9G1f0IjjWvo0OECD4piQ0ITJdi9TgGqa1ra4ApVkkzsgC+9wa9yIUBVM9UIYcP2DgC8B
 2m+PGm+MQpWvY7GDxAqpXs1kHphe2LN+hfSIu6lbNxHA+05pA0CffrurUzsbSvLc5TZyDI2bsmW
 AHoCWm69+YLsjpllY+sFn6dIMKY1XFfmXqYhk+ztvVNKOTa+WJLKIhaEbxxZF4yRg5qhZnXTXVu
 MYv3gisnBGa8aiuIjFBhLPoulVj1VBywWTD36V/Bzd4oFhu1YF4gRdwNRmJZzj0NPKApdH4C2Iw
 3U8KfTEMRjE1nmaoO/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA4MCBTYWx0ZWRfX7RoWLnY6rR9Q
 3OIkEbbgMznczzlqiS+nM4qEnTaRGa+6u8QvtYUHqs7jfOxPxUgR+fTL70/6+6kcJRwzupGTUHH
 PhSsVRAbbaShXKocbEYxVbmBbFaT9Ww=
X-Proofpoint-ORIG-GUID: WwDsRbYs7LSdJPzSrQq8tAiga5pVr6pq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190080

On Tue, 18 Aug 2026 15:33:49 -0400
Anthony Krowiak <akrowiak@linux.ibm.com> wrote:

> Three related problems exist in the handling of KVM interrupt and page
> resources when a queue is removed from the host's AP configuration
> while assigned to a mediated device (mdev).
> 
> Problem 1:
> ~~~~~~~~~
> AP_RESPONSE_Q_NOT_AVAIL not handled in vfio_ap_mdev_reset_queue()
> 
> When the AP bus removes a queue device whose adapter or domain has
> been removed from the host's AP configuration,
> vfio_ap_mdev_remove_queue() is called. If the queue is still in the
> host's AP configuration at that point, it calls
> vfio_ap_mdev_reset_queue(), which issues a PQAP(ZAPQ). Since the
> adapter is already gone from the host configuration, ap_zapq() returns
> AP_RESPONSE_Q_NOT_AVAIL (0x01). This response code is not handled in
> vfio_ap_mdev_reset_queue()'s switch statement and falls through to
> the default case, which issues a WARN but does not call
> vfio_ap_free_aqic_resources(). As a result, if IRQ handling was
> enabled for the queue by the guest, the KVM GISC registration and
> the pinned guest page holding the notification indicator byte (NIB)
> are both leaked.
> 
> This is fixed by adding AP_RESPONSE_Q_NOT_AVAIL to the same case as
> AP_RESPONSE_DECONFIGURED and AP_RESPONSE_CHECKSTOPPED in
> vfio_ap_mdev_reset_queue(). Like those response codes, Q_NOT_AVAIL
> indicates the queue is not operational and no further reset attempts
> are possible; the correct action is to free the IRQ resources
> immediately.
> 
> Problem 2:
> ~~~~~~~~~
>  AP_RESPONSE_Q_NOT_AVAIL not handled in apq_status_check()
> 
> In vfio_ap_mdev_reset_queue(), there are four cases that indicate a queue
> reset has not yet completed, in which case apq_reset_check() is queued to
> a work queue to verify completion of the reset operation. This function
> uses the PQAP(TAPQ) function to get the queue's status and calls
> apq_status_check() to verify whether the reset has completed, failed or
> needs to be executed again. As described in Problem #1 above,
> apq_reset_check() does not specifically check for AP_RESPONSE_Q_NOT_AVAIL,
> thereby potentially leaking KVM GISC registration and the pinned guest page
> holding the NIB.
> 
> This is fixed by adding a case statement for AP_RESPONSE_Q_NOT_AVAIL to
> apq_status_check() and returning -ENODEV for that case. The caller,
> apq_reset_check() will then check for this return code and call
> vfio_ap_free_aqic_resources() to prevent the leak.
> 
> Problem 3:
> ~~~~~~~~~
> vfio_ap_free_aqic_resources() leaks saved_isc when kvm is NULL
> 
> vfio_ap_free_aqic_resources() guards the call to
> kvm_s390_gisc_unregister() with:
> 
>     if (q->saved_isc != VFIO_AP_ISC_INVALID &&
>         !WARN_ON(!(q->matrix_mdev && q->matrix_mdev->kvm)))
> 
> If matrix_mdev->kvm is NULL -- which can happen when
> vfio_ap_mdev_unset_kvm() has already run and cleared kvm before a
> subsequent cleanup path reaches this function -- the WARN_ON fires
> and the entire block is skipped. This leaves q->saved_isc set to a
> non-invalid value, creating a potential double-free on any subsequent
> call to this function.
> 
> When kvm is NULL the KVM guest is already torn down, so
> kvm_s390_gisc_unregister() need not and cannot be called; however,
> q->saved_isc must always be cleared. Fix this by separating the
> kvm_s390_gisc_unregister() call from the q->saved_isc reset. The
> WARN_ON now guards only the genuinely impossible case of matrix_mdev
> being NULL. A NULL kvm is handled gracefully by skipping only the
> unregister call, and q->saved_isc = VFIO_AP_ISC_INVALID is set
> unconditionally whenever saved_isc was not already invalid.
> 
> Additionally, add an else clause to the host-config check in
> vfio_ap_mdev_remove_queue() to call vfio_ap_free_aqic_resources()
> directly when the queue is not in the host's AP configuration. This
> serves as a backstop: when the AP bus fires the driver .remove
> callback after an adapter is removed from the host config, the queue
> is by definition no longer addressable, so vfio_ap_mdev_reset_queue()
> would always return Q_NOT_AVAIL. The else clause handles this case
> directly without the unnecessary ap_zapq() call, and ensures cleanup
> occurs even if kvm has already been set to NULL by a prior call to
> vfio_ap_mdev_unset_kvm().
> 
> Fixes: b9bd10c43456d ("s390/vfio-ap: do not reset queue removed from host config")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

Acked-by: Halil Pasic <pasic@linux.ibm.com>

Looks good to me functionally. Style-wise there are things we could talk
about, but we don't have to :)
