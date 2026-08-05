Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576F51A9F85;
	Wed,  5 Aug 2026 12:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785933819; cv=none; b=qUdGLuoIEXDqCEWXKh0N7ixxHSXZkZJq77PeHG/mHYCZKwOhlarDJ+q/pTfhSpGJTRj8c8oQ+GE2qLddYwLXv+k4zuZkTa7+lZD4BSjaJxFQE3cZ97iWsVjAebyw2CRv4uazav29Mk9RESKybBhlhNgcT1Gjensux8tg7evIARY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785933819; c=relaxed/simple;
	bh=BqK4RCyDSPJws4UAKsVESRBrX8Gg9iTbyt5/MYk45J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onlr7mh5YONRo94trlZTIfjMS7magM1JXkE1wYmkgQJPqw7z0E7Tq2k6O4uQffxz58usTy2oRCkHxlmyh9me8QK39Be7n5ANvxo1N9QYpYhpw2COmU2Hvm1Li9wKoYam1e4h/Zbq0OAkliUkYxCP20HLI2C6mAC+XPvPV0NvO1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kc6GX9gP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kc6GX9gP"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675CHuXH3825440;
	Wed, 5 Aug 2026 12:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=UKi8JdGx6pl5dIO9BdCqHy7Ujp/Eer
	s8T03JVPEuAz4=; b=kc6GX9gPfYvQv39BTzKcaLgBkp+Tt+W/ETtIRNDX0/AqQ5
	VyM+Rr1FvXTIe8qq9u6dAMCebGhVQCKix2A0HJSjyXOoiO1na/aRcnQqW+OH/Zlx
	f0nqunfypEQrUvfKcRucH0rBKLBK2m7hiZqK/D9TuMgMUKVlOAbGmuFFLJ7EtNIe
	c8HV8+HvV9+aW6e/PDt/Xk250UN3kQ97MPiLtR5OVZ9+63ZcgCbQeEKmOD3bWTEb
	GhjsPPJW3/Oy1eIsZFrur5zdjp3/ITI1S/qFZaEb00CeFZX/b+p/ZMJgWbYe+IPt
	xp1h0Oc1iZO/d66g1DKHMNNLGgfyZWcE8IWvJ2og==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h531ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 12:43:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675CfIbv021632;
	Wed, 5 Aug 2026 12:43:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtypa9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 12:43:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675ChWsb32375236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 12:43:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B626320040;
	Wed,  5 Aug 2026 12:43:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67A3C20043;
	Wed,  5 Aug 2026 12:43:32 +0000 (GMT)
Received: from osiris (unknown [9.111.89.228])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  5 Aug 2026 12:43:32 +0000 (GMT)
Date: Wed, 5 Aug 2026 14:43:31 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] s390/pci: Rework__zpci_event_availability() to
 remove conditional locking
Message-ID: <20260805124331.76476C3a-hca@linux.ibm.com>
References: <20260803142907.1771509-1-hca@linux.ibm.com>
 <20260803142907.1771509-3-hca@linux.ibm.com>
 <0b65164f7442fec896c76e0a39a8d9a43f98b721.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b65164f7442fec896c76e0a39a8d9a43f98b721.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA5OSBTYWx0ZWRfXxTw0FvmJWatC
 cV0PF7KWvTSB2mLyoEDS4pr3S1fJNg6OSVj8SCQmtYDe2QdnrDaQtuBNCNMLmVyBXN1TQjgF9Jp
 BXcnZYmqUEyp2OXxKBdWxRxUptPUxtE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA5OSBTYWx0ZWRfX+O4dSCtX3OaW
 ytbH7bgV/3GMsF3rPAe5F32XDe4YblMvcy5PksIHtnBIl1Plu61h/yjv8Yh9bqSkMX79ufc5Nik
 Y8YYqmTugd8cJc5zP6JD66LGYoLYxP0TTr8/DQLprVkU0fJOIw4aXj7vyo+/NHArddoQBn0f82o
 hrzg/t91Y9FAGwL2sZxO72H+jRiwis5Rw8cSj26kY+y5Mqf6QnyX6MLLsBHqUkNxPFF7G2a1aL1
 7wR07MLf9EB3Uw/YWYhPHrqPoXm6MAEDR3y1s0ZT9niXsBsrSdAbx95n8uRiV55254uHyoifcqc
 WyuMxLq6A2RWdTjm5Izs2G9Y3Jm3DneJ1mcYeY32kFU0svx96CuPBqSbQKUL2eEHFv2ytgfwUAf
 Vy76TwONY2sCF5nJPPnFIbYUiAH6c1qL8W/ZFSwOURKNTBp0V6/x6BDL2Db8g9Y0gm+nVwbOd6+
 Jkuu/A5aGIDncbrdStg==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a732ff9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=mNfDcqC6nlNDL6aBd7sA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: iVb_Y1Icl0tc9IHjbb-p41ZA_fepwZXE
X-Proofpoint-GUID: iVb_Y1Icl0tc9IHjbb-p41ZA_fepwZXE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050099

On Wed, Aug 05, 2026 at 01:32:10PM +0200, Niklas Schnelle wrote:
> On Mon, 2026-08-03 at 16:29 +0200, Heiko Carstens wrote:
> > Clang's compiler based static context analysis does not work with locks
> > that are conditionally taken like in __zpci_event_availability():
> > 
> > arch/s390/pci/pci_event.c:402:10: warning: mutex 'get_zdev_by_fid(ccdf->fid).state_lock'
> >   is not held on every path through here [-Wthread-safety-analysis]
> > 
> > Given that code which takes locks conditionally can be considered
> > suboptimal rework __zpci_event_availability() to get rid of this.
> > 
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > ---
> >  arch/s390/pci/pci_event.c | 108 +++++++++++++++++++-------------------
> >  1 file changed, 53 insertions(+), 55 deletions(-)

...

> Personally I think I'd put the 0x0306 and each of the two switches in
> helper functions to improve readability as this is getting awfully
> long. Maybe something like zpci_event_avail_any_device() (0x0306),
> zpci_event_avail_new_device() and zpci_event_avail_existing_device().
> 
> If you prefer and since I'm doing a follow up for the missing locking
> in zpci_reserved_devices() I can also do that in a separate patch. Also
> just to clarify Sashiko is right in that the missing locking is a pre-
> existing issue as the state_lock was already not taken in that case,
> it's just more obvious now.
> 
> Either way, functionality looks good to me so feel free to add:
> 
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks, I'll address the two nits for patch 1 and 2, and will send a
new version. However I prefer if you do additional code refactoring
with addon patches, so the result looks exactly like you want it.
Otherwise we will go back and forth :)
