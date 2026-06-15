Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5044C30DED1;
	Mon, 15 Jun 2026 21:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781559778; cv=none; b=dUEKY/+gln5XbX9m9cefN0QWb+VJnSpnF69vYOWb55W0KJvc05ypCcP8Ty5xovHL3B3h+YsSWMvirbhglPbxeDYdVZXfxTKbNf3ifkkyK3hCJirTuwRgtnsgTwzYuNWqSdTsK4wHEm23ln5/1tCdPvzM3BS7y6++UGO2MGZvKDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781559778; c=relaxed/simple;
	bh=HqUxW0V49/0UoJHgRXJSCIzkNCsDCNtrkXW3h/rpIEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aSdSZCVwG1slA8ejUIKeV9ddE1OKwWgLHsS52iwkyQXjwKdfGzuPGhp/Qdj0V60VRY4uSCNugQ52J7csU/dOIs8fttQ0txhl7SwiDXVfgSyVeRLmoQMWi/jOubPZei524knVaFEr/wcuPbgnNeowwLoYu8DbzjnXqgSjG7TYFc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CFKOVVQc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CFKOVVQc"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FJIgYw3359219;
	Mon, 15 Jun 2026 21:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aiGhGx
	Xdcvu8IYXWj0vbqpMf8cp7IlZZh0o9eStHOI0=; b=CFKOVVQcQ5nCz0l6Iarr+o
	QXX3IiHGwt2/pgmdv34UocDRC0sIz+CEbgr4zRDE2XzO7ScwJ5I8JSIn6sN3EoEo
	Fl2nWz6VW++CZhRXzUEYZCEFWIm2/Ir5xT1tjQiKK/rc5AMuvYO+oRSREVJ1QkQH
	56oBNnw/Wmrfc/z/L2zXqJFzGXRwcL9aPaBNlqL4HSiDRxqHCaefmmdUVQYMy/uK
	IaKALpMVc1A5TsDyMbqPl90EcKthjv6M5ho4moWTk4MrMibuI1xomgvE9kUFuLkn
	/w6YYAL3Nzlza5Ek20OxSO1jVCQBxkHIg2XbQDHvepVNpV4VRQJ/0b9XtM3FkCbg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1eg2948-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 21:42:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FLYikp010751;
	Mon, 15 Jun 2026 21:42:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eskrg8aaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 21:42:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FLgnu262718248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 21:42:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1C3420043;
	Mon, 15 Jun 2026 21:42:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0F8020040;
	Mon, 15 Jun 2026 21:42:47 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.111.55.56])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 15 Jun 2026 21:42:47 +0000 (GMT)
Date: Mon, 15 Jun 2026 23:42:46 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: William Bezenah <wbezenah@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org,
        farman@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        mjrosato@linux.ibm.com, vneethv@linux.ibm.com, oberpar@linux.ibm.com,
        virtualization@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v1] s390/virtio_ccw: Also suppress -EINVAL on device
 detach
Message-ID: <20260615234246.0ec5d947.pasic@linux.ibm.com>
In-Reply-To: <4d7fc371-4357-496f-9774-1f7a7c1a3091@linux.ibm.com>
References: <20260612155407.199218-1-wbezenah@linux.ibm.com>
	<20260615002309.052e0614.pasic@linux.ibm.com>
	<875x3jn94r.fsf@redhat.com>
	<4d7fc371-4357-496f-9774-1f7a7c1a3091@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIyNiBTYWx0ZWRfXypmxDw7sPTvq
 YVPgTH7viaJSgIo4Lfmyet+JHdi161BNgAAF1xVEbCGMgevdys2FPapIhibevOoQ1kw0YoSbW33
 6t3OiaUGzJ6rPdSUPcarjPZ/F1WLb3M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIyNiBTYWx0ZWRfX/pyqUh/SQ5W9
 awguNgCEpRV2ETBz7qT9D10yXy1OnF2+KOm6Vr+Mfex+Asj50VeUekEQXa81TvaSsOKrtVHDqnX
 C3v/FBLOSAa/ERkxQDwjzNUegUOAViWWKfQtSerKdI7E8ZUL9B5R3XUJ29x064PesrxthDUqBBJ
 0p1qcRTLrvrkwNfvJ9gDr/JKA17u5foTWFXl8YSwG0oAm7EewcdeQ5j5cJ6gpEJ1VJJ3Z6mlp5g
 Kv8M9vFUDw09+wqF1Uew2iHly5btASakyJMuELsjeRr1xJcTf3YVYMngtCIE9gXZvfB17T/yCpR
 UwUbZ2TQbcS9q7Ya1ziuF9H5ik4TjVTVCN0zQwG7+ilpVVWF7mWE6uS7ksISFoLmoSABSuZh3mb
 xJtC80hh9sgj4KSq5li6RjQY407b3l+ioFTB/Iqq/H0EJP/t80QyWW4XyFI/ONrKtKA/HKdd7lE
 6KfjI6YQMVM1b9KfW+A==
X-Proofpoint-GUID: HtNxyvI3S64s_BL2gddbxTjypBGbSW9E
X-Authority-Analysis: v=2.4 cv=NuDhtcdJ c=1 sm=1 tr=0 ts=6a3071dd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=XwmfqP6izPx3aug6iF4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: HtNxyvI3S64s_BL2gddbxTjypBGbSW9E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150226

On Mon, 15 Jun 2026 16:01:55 -0400
William Bezenah <wbezenah@linux.ibm.com> wrote:

> On 6/15/2026 10:58 AM, Cornelia Huck wrote:
> > On Mon, Jun 15 2026, Halil Pasic <pasic@linux.ibm.com> wrote:
> >  
> >> On Fri, 12 Jun 2026 17:54:07 +0200
> >> William Bezenah <wbezenah@linux.ibm.com> wrote:
> >>  
> >>> Since commit 8c58a229688c ("s390/cio: Do not unregister the
> >>> subchannel based on DNV"), subchannel behavior following a device
> >>> detach has been updated and results in -EINVAL being propagated
> >>> rather than -ENODEV, originating from ccw_device_start_timeout_key()
> >>> in cio/device_ops. In the end, the virtio driver has no ability to
> >>> react to the difference between device and subchannel states here,
> >>> and during detach, both -ENODEV and -EINVAL indicate the device
> >>> cannot be used and should not be treated as errors requiring
> >>> attention. Update error handling in virtio_ccw_del_vq() and
> >>> virtio_ccw_drop_indicator() to suppress -EINVAL in addition to
> >>> -ENODEV.  
> >> Hi William!
> >>
> >> Are you saying that ccw_device_start() started returning -EINVAL
> >> since 8c58a229688c ("s390/cio: Do not unregister the subchannel based on
> >> DNV")? Or did I somehow read the paragraph wrong?
> >>
> >> The funcition ccw_device_start is documented to return:
> >>  * Returns:                                                                     
> >>  *  %0, if the operation was successful;                                        
> >>  *  -%EBUSY, if the device is busy, or status pending;                          
> >>  *  -%EACCES, if no path specified in @lpm is operational;                      
> >>  *  -%ENODEV, if the device is not operational. 
> >> and the commit message does not say a thing about introducing -EINVAL to
> >> the mix.  
> > The function may return -EINVAL for non-enabled subchannels
> > (i.e. pmcw.ena == 0), maybe we get an all-zeroes schib with dnv == 0?
> > I'd expect it not to be enabled in that case anyway.  
> 
> Yep, that's at least how I've come to understand what changed. The
> function ccw_device_start_timeout_key() has always returned -EINVAL
> for non-enabled subchannels (pmcw.ena == 0), though it's not
> documented in the header.

Wasn't his -EINVAL actually introduced by commit:
823d494ac111 ("[S390] pm: ccw bus power management callbacks")?

> 
> What changed with commit 8c58a229688c is that cio_update_schib() now
> updates the schib even when DNV=0, rather than returning early as it
> did previously. Somehow this update results in pmcw.ena == 0 in
> ccw_device_start_timeout_key(). Previously, it saw pmcw.ena == 1 and
> moved to the condition (cdev->private->state == DEV_STATE_NOT_OPER)
> where it returned -ENODEV.

Sounds fishy to me. As far as I understand the DNV takes precedence over
all other pieces of PMCW.

> 
> So the commit didn't introduce -EINVAL as a new return value, rather,
> it changed the subchannel lifecycle such that existing paths now
> propagate -EINVAL rather than -ENODEV during the device detach
> scenario.
> 

I'm not convinced returning -EINVAL in the given situation is the
right thing to do. Peter, would you mind to chime in?

Regards,
Halil
