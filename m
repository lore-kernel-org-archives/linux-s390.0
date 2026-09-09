Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B2C551994
	for <linux-s390@vger.kernel.org>; Wed,  9 Sep 2026 12:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788956955; cv=none; b=mxY/tGvpgDXcP4tlTPCu5BpsjlWYmVgjGqPF2ilwOGGzEV+XuqY8GXFq2gv1sEitnsCNLpnOJs3wKna9fsmu3jCnP2KD7Mi6Thn6RRNYGyrDRbjU+yUFPkcs+ZBGAyMl7EWwAuJXbwC0SEJBUhlIAuL3NfNHM6MLVqdzfjvImz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788956955; c=relaxed/simple;
	bh=k93o+oFP6LqdTcX+RO7OryU0vhZNNebtagcZxagRJUY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NYy8YcE0IiKx9lik+6XEoZuZNAlehak/mX+iYua4QhxGAy61uj+KZ1WTDSY4ZiQhSXJREmSu1OTDXjL7OpMP2QLuYgy1Czm64jA8Du+g77x/DQPAnT4luaHkL1b9o9YV8w75iGa3r/PRhofsFQLzlhS+i6zd7aBUEE8yKk+9Hsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WUF0T4G8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WUF0T4G8"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1O6o3817316;
	Wed, 9 Sep 2026 12:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=IVZweEGG/gSAg1GNA9fRChAIGXVGF9
	NGSLF4y8w9W9g=; b=WUF0T4G8MzL+KUSuMPFw7PD1xvBZb+opGQpocOkgX2qeAA
	/tTyGex5n8UIbPni/63nZyNuH+mbbSYan4F8g4O5LvCyyHqR/OzDNJIGXmE6tUsa
	Y7gplTuGOvpKUnVUyHr3YOG6k13X9fcKjtn2g0lVMvf6u7TT4jXSdjdzH3WJT8y+
	2vOzQ+edIJow/f+zZpGtsaV6TZLeDMCTX/b0rLys76Xhww95Ie+7VXIlTFOY8233
	99yizmFy8rgAkJXbiejVBzVB9/FP/+7+nmRz9+s8Vat+mbiBY+leCw2c4B8Rg9HF
	6qaG4M4H43lIXvrH6ftEQ+2tqRixveoHxmC4hXGQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbf45s89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 12:29:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689CQIkT032741;
	Wed, 9 Sep 2026 12:29:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gh03yj0hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 12:29:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689CT7Le51446184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 12:29:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A12BC20063;
	Wed,  9 Sep 2026 12:29:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84AEE2004D;
	Wed,  9 Sep 2026 12:29:07 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  9 Sep 2026 12:29:07 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.vom>
Subject: Re: [PATCH] s390/stp: Drop CLOCK_SYNC_STP
In-Reply-To: <cffc6734-19c8-439d-a55b-79bdedd54eab@linux.ibm.com>
References: <20260814072223.2218864-1-svens@linux.ibm.com>
	<20260814073450.908631F000E9@smtp.kernel.org>
	<cffc6734-19c8-439d-a55b-79bdedd54eab@linux.ibm.com>
Date: Wed, 09 Sep 2026 14:29:07 +0200
Message-ID: <yt9d4ifyvca4.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: icBFUtIGrC6uXGxG0OygMCV-B4jbwQSr
X-Proofpoint-GUID: icBFUtIGrC6uXGxG0OygMCV-B4jbwQSr
X-Authority-Analysis: v=2.4 cv=DbEnbPtW c=1 sm=1 tr=0 ts=6aa15118 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=d7ODBpsrPao4Sd31h9IA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEzNCBTYWx0ZWRfXz9u85XNyd9qZ
 x/nu1nOeUGUF4wAyLFpGTvHrDIJulxkpLJHkcN1yh851xJZpw6losfvL0mgI8u/lrbNYpsIrGKg
 A1mW4kY4B8hr3/JWgrg0jvWiO/rxcUkzzyprXsaBM2bhUnYnb3KNi0NiANiRou9q5qolUAcoFgN
 N0+or2bEBHMEhfDOLgn1dl1ObNXq1FdN7d35VYuUkxtzj4Q0x/mEZ7Ro/gqL3S4jWdh3urefKPy
 Jx8YaRzO+cQX7b3sAXiWkslRra9KJ3U/ni2aa3QNlZ4TaQIxSXIYqfKW5id2jaW3hZbNEkTM9Q+
 I+brOOi/RTHV8TxTaARLidym3KfEqDevjXZVlNQcLTe69V0iccUZuLFGbKz+4y8H02TiXjM2NeJ
 5lnje6Sx0GuQ4LA4bc95qFhBZkLuE4YERp4J2nQUsGy/i5h9HIBTCBODwng/X/5h7oS4h2fkSnM
 9rUShI7ytCM6jZ4LKoA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEzNCBTYWx0ZWRfX3ub06tjmW/Lj
 JPbbeaOx4iEbqjhc+WP3Yv66NVi0/5KtDvADxNX2giJ376C2mxaxuSmdslVHSFL9YyIUHN5yKXU
 c56hohMju69HnJDRkwZITUj/dZv+rm4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1011 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090134

Stefan Haberland <sth@linux.ibm.com> writes:

> Am 14.08.26 um 09:34 schrieb sashiko-bot@kernel.org:
>> [Severity: High]
>> Could this change cause a boot hang on systems with XRC-capable DASDs
>> but no active STP network?
>> 
>> Because stp_online is initialized to true, if the machine supports the
>> STP facility but is not connected to a usable STP time source, time
>> synchronization won't occur and stp_online will remain true.
>> 
>> With stp_online remaining true, get_phys_clock() will continuously fall
>> through and return -EAGAIN, rather than safely returning -EACCES as it
>> did prior to this patch.
>> 
>> The DASD driver ignores -EACCES but propagates -EAGAIN:
>> 
>> drivers/s390/block/dasd_eckd.c:set_timestamp() {
>>     ...
>> 	if ((rc && !private->rdc_data.facilities.XRC_supported) ||
>> 	    rc == -EOPNOTSUPP || rc == -EACCES)
>> 		return 0;
>>     ...
>> }
>> 
>> If -EAGAIN is propagated up, will the block layer endlessly retry the I/O,
>> resulting in a complete hang during boot?
>> 
>
> From what I see, Sashiko is right. This will break how the DASD driver
> actually checks if the clock is enabled and in sync.
>
> The DASD driver relies on -EACCES to know that the clock exists but STP
> sync is not online/applicable which in turn will skip it, whereas
> -EAGAIN means the clock does exist but is not in sync yet and we should
> wait and retry, which in turn leads to endless loop of request never
> being built because we never get a valid timestamp.
>
> So I guess we will still need a third bit to differentiate those states.

If I understood the code correctly, it would only block until STP is in
sync, so this is expected behaviour - looking at z/VM documentation (especially
the XRC_OPTional flag), DASD I/O should be blocked until time is in
sync.

I think the correct way would be to add a patch on top that adds the
XRC_OPTional parameter to either block DASD I/O when STP is in unsynchronized
state (current behaviour) or just omits the timestamp when XRC_OPTional
is set.
