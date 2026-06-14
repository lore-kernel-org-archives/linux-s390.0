Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF8D33CEA5;
	Sun, 14 Jun 2026 22:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781475801; cv=none; b=BDCJzQgngN7Nfp9JVw3m12L3o9C/wrg0c7yhcDuErm7ZvGwH5WtqBesbs/F/Ff9LUj40p+7d7dYn6UzA6keHnRWZzhUvuY6yoMnYm2A7sdw9gDsYbGIglzgioaQ83MNee52fssg5fcKRhIq8V/iovKjDtrlKh2f0zmtJoD8Ppc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781475801; c=relaxed/simple;
	bh=1aBWUx4L/o7ljcU7j2WP15Mknm20m9APEp3SipKIOrg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i4S4ra/XeBPM1ykiaipctWSGWAJ9HaVU+cN3OslvK8PZilwLyUZ0Mfmi32NL9gXqfvMvl5BTi127oi24BITNyAKR4G6EyPCSAn05zjUo2gfgaTwfUJL74NQcQSh7xz42F65qcl191N3swAK//K5lrGKAB6z1to8ioZe3H7QuQ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qEsQcGlR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qEsQcGlR"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ELISpw449574;
	Sun, 14 Jun 2026 22:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ATaeA6
	DaGzSwKN1SckKkty4l46yl3n1YxiAWRAmMwtk=; b=qEsQcGlR+yFAcRimuvc0nf
	gJd7dwCL08kPVzcqWUIKhkMOw0V8+phh4Qanh97oM75v5cuVplLF7opc0+1k1iTG
	nADoJFpl6BqTH3ODFKQp1s4YhOkYuqIHm165S20dL9qGFHRLRgvVakpllOS92Bh/
	LpELET1C8hGTrd59fP7nxYyOQ4GZYLz7KBF7pemU74eB0BX0HFcoYiv8yMXoWGkb
	GczIjHanSIeWed1vJXlgX1+lVdANctABOv+TTUncp1su4JZcdDQmEMs0oOhiaUvR
	JRLoysg76HP27H8M8CE9+VrDxD3WSzAaBHgCxgQAr7Q1/xmUSxilM+1JjOTvnjrw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1h7x0f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 22:23:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65EMJZEn017794;
	Sun, 14 Jun 2026 22:23:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eskrg3ruc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 22:23:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65EMNCXM61210880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Jun 2026 22:23:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13F3D20043;
	Sun, 14 Jun 2026 22:23:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FD4D20040;
	Sun, 14 Jun 2026 22:23:11 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.111.26.108])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Sun, 14 Jun 2026 22:23:10 +0000 (GMT)
Date: Mon, 15 Jun 2026 00:23:09 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: William Bezenah <wbezenah@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, cohuck@redhat.com, farman@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, mjrosato@linux.ibm.com,
        vneethv@linux.ibm.com, oberpar@linux.ibm.com,
        virtualization@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v1] s390/virtio_ccw: Also suppress -EINVAL on device
 detach
Message-ID: <20260615002309.052e0614.pasic@linux.ibm.com>
In-Reply-To: <20260612155407.199218-1-wbezenah@linux.ibm.com>
References: <20260612155407.199218-1-wbezenah@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDIzNyBTYWx0ZWRfX6TVi57UkFMQc
 KBOKm60tR0i6hxs+YW6vcdv5XAiJmWPf1jyjZ4snhmUPNxhd14L2jK34v6FAXMSGwF1EI53x/j9
 z61GUXwKfmOJ+A92f3YIzvJoQbGRXks=
X-Proofpoint-ORIG-GUID: xLc9ZGdJBNDdQsnwXVC9u7ExuU0fd0ub
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDIzNyBTYWx0ZWRfX6gOVlN+jbc3h
 tyJElbOZMed3VFZ2yOX8hogFn9WoxLEFw4nxcXCAeqzK+7CWXAE983A9memtYPM5Qux5l10h7ul
 hMHK3Ap7SvgvBvHf6AOi/Ez4JIlyVryfZd4ekNCm6tzJpEo0msaq6apc8y5kKH0sQsBRqlhx8BX
 E16QER05I6TwiDofixmfT0XdBWi6HPk9tlfKw40l728HxvJGlRR7iSeNDDdPEs707mhEG9cc8Z5
 oElQ0+uwahuCfm8bwkPYAOYai6gm5tNkFDUBmuNhG3ZsDSLjKUHz5c8k7R4JHHCF5JwKJ/9rvZD
 AfCnreG56yPE9WNHa8NEPWK1mWHEx86ppN8FVnW4DTrZwI1IQF7vINSA1IbOkXsAnhEA5IpcLwh
 qrDBs1eKKKf9DsDQZ8nat84bDOU4v4zgia9cHCbT7apmPrv5JRx2ZynTlcw3a5s9T0tb/ceb730
 jm/apoluBGcJX85zHlQ==
X-Authority-Analysis: v=2.4 cv=U9uiy+ru c=1 sm=1 tr=0 ts=6a2f29d4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=XgNADJiZk9AC71OXotwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: xLc9ZGdJBNDdQsnwXVC9u7ExuU0fd0ub
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_05,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606140237

On Fri, 12 Jun 2026 17:54:07 +0200
William Bezenah <wbezenah@linux.ibm.com> wrote:

> Since commit 8c58a229688c ("s390/cio: Do not unregister the
> subchannel based on DNV"), subchannel behavior following a device
> detach has been updated and results in -EINVAL being propagated
> rather than -ENODEV, originating from ccw_device_start_timeout_key()
> in cio/device_ops. In the end, the virtio driver has no ability to
> react to the difference between device and subchannel states here,
> and during detach, both -ENODEV and -EINVAL indicate the device
> cannot be used and should not be treated as errors requiring
> attention. Update error handling in virtio_ccw_del_vq() and
> virtio_ccw_drop_indicator() to suppress -EINVAL in addition to
> -ENODEV.

Hi William!

Are you saying that ccw_device_start() started returning -EINVAL
since 8c58a229688c ("s390/cio: Do not unregister the subchannel based on
DNV")? Or did I somehow read the paragraph wrong?

The funcition ccw_device_start is documented to return:
 * Returns:                                                                     
 *  %0, if the operation was successful;                                        
 *  -%EBUSY, if the device is busy, or status pending;                          
 *  -%EACCES, if no path specified in @lpm is operational;                      
 *  -%ENODEV, if the device is not operational. 
and the commit message does not say a thing about introducing -EINVAL to
the mix.

Regards,
Halil 
