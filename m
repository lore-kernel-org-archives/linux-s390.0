Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4D386329;
	Tue, 21 Apr 2026 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776785479; cv=none; b=Ekb6j45breTkYYCRqdPIJsETduJQOomk3z4gdCbDizzh9GBWkElQjX9nkG2J0CHLBmza9Q3Un/AuObTcEI7duw+QcRW/t5lVrOMCxHJLDM0KnDm6iKJOiv4oTZN6mPzy/UY9YPKxhe6awP4o2UHYQ5Ji8YV7e2hrmG9FV6txRuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776785479; c=relaxed/simple;
	bh=Ot/aV5/OPfVLx1JSw9FK0sve4/npqydwLb71wWa+7+4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:Subject:From:
	 References:In-Reply-To; b=rgqyKj3ScWhV//HwObgjv15j0ZCwr0R3hjAxRwzvkNsw6YKcUUmYU1lJSwsL6GmLAWTTcH0WkHmrQb43wRpI6A+v2Eh2PIhv52jmUC+No4XNN/ff+aulgAOV6Q+jvP5pi+LN01J+ZqWh1m+2pVBuvcicDKG2l4q+6Y0UOYZUKhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bmY9BDmt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bmY9BDmt"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LBspY51535555;
	Tue, 21 Apr 2026 15:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yWcVu+
	u1fsl08A8aFUbFMzfROjRDWMKsM5tr0zozQbw=; b=bmY9BDmt0TSm+F6zew51oL
	J7ZvvWcNyOTH9Uj6VFOuQSXyF0TV7H/X4LcHutDGtJaw7cJatw+G+pS3z/A/Brk9
	JDNu0O1DO19DShC5cfSQhW2Ss2i+OLY7Z/6udz2MMetDIWfSfgue8zF4ER/+3dhK
	yZshMC4K8i4RZDn04ONJes22kmdsV/ED/9PXyknZiXABr0rK+F4x6Z+3BjFBNMmB
	PlNOUGR/XK/2lmEV0CKlKnAgxXC+Q0CnT+ajXbKQTS73L2Zs2gp4/HK+3f2ok8ww
	3rj8YO5U712PgV99nM/87rv39slZVIqDP3jHUKorf3SzAsoF5hPq8R7k+Fed33Xw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k6m8ru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 15:31:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LFKLs0003669;
	Tue, 21 Apr 2026 15:31:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmpyy10m9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 15:31:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LFVCvH46137730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 15:31:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 892CE20043;
	Tue, 21 Apr 2026 15:31:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7475720040;
	Tue, 21 Apr 2026 15:31:12 +0000 (GMT)
Received: from darkmoore (unknown [9.52.198.32])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 15:31:12 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 17:31:07 +0200
Message-Id: <DHYXVRBLWI9V.2EF7C9U91BQW3@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>, <imbrenda@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <nrb@linux.ibm.com>
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>,
        "Janosch Frank"
 <frankja@linux.ibm.com>, <kvm@vger.kernel.org>
Subject: Re: [kvm-unit-tests PATCH v2 2/4] lib: s390x: sie: Allocate
 physical guest memory via memalign
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
X-Mailer: aerc 0.21.0
References: <20260420084933.251244-1-frankja@linux.ibm.com>
 <20260420084933.251244-3-frankja@linux.ibm.com>
 <DHYXKO2IPF13.1SJ3D8S49W7BZ@linux.ibm.com>
In-Reply-To: <DHYXKO2IPF13.1SJ3D8S49W7BZ@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L78theT8 c=1 sm=1 tr=0 ts=69e79844 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=6CX5Zf9KZRiv3f7GAsYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE1MyBTYWx0ZWRfX4pNbymabPAD/
 jG0o+Z1SQ/7V7y3lI4kj/fS1t18h2uAJ69Yg/nrGZqD4YKk9H9KNYrDwjj+H2Kf72rWoVCclIGI
 8WIssmtSDnzKQfW76UVQslxSn9XNp7DnWKm9wAm0zHbuz//Y0R75WOhh6UBKEEWmvdr8EUN2cVw
 QoERQ88wk6ohTVxiz9L27KOkn0f0aGPPysJ9MNWF7gx4vjhEcaQwupE4fhsTQq4n6TPR2/gDXmT
 3ia/TlIzJ/zaqntv5WS97pYuG1Tq7WV+ocunBnGGxn3i8FxrXYZq4ofLyxXzOWdiYcLeNJUeygu
 8mnE4pH7PjZAo3PRw+HcgofO/hQOzQ9HXRIF0EcbrhaJb9QCjvLI5YH8+O1vwZaaBZda0fomcGK
 vHk1HY5+yzhRgD4d5m2FIVi/lGqYSKciukrbRqgJ+FKQ7Um4V01mslfW7PvPupHUspjK/jNimkv
 VyI1ZFgOVVFrRBoVqIw==
X-Proofpoint-GUID: Qtjs-F_9mkR3JpO6tZOpc3Qq5ot6ie16
X-Proofpoint-ORIG-GUID: Qtjs-F_9mkR3JpO6tZOpc3Qq5ot6ie16
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210153

On Tue Apr 21, 2026 at 5:16 PM CEST, Christoph Schlameuss wrote:
> On Mon Apr 20, 2026 at 10:44 AM CEST, Janosch Frank wrote:
>> alloc_pages_flags() alignes the allocation on the same order as its
>> requested size. Since we use virtual memory for SIE we can instead
>> align to 1MB by using memalign() which is less wasteful.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  lib/s390x/sie.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/s390x/sie.c b/lib/s390x/sie.c
>> index 47d4cdde..b1b0a8a0 100644
>> --- a/lib/s390x/sie.c
>> +++ b/lib/s390x/sie.c
>> @@ -171,7 +171,8 @@ uint8_t *sie_guest_alloc(uint64_t guest_size)
>>  	guest_virt =3D (uint8_t *)ALIGN(get_ram_size() + guest_counter * 4UL *=
 SZ_1G, SZ_2G);
>>  	guest_counter++;
>> =20
>> -	guest_phys =3D alloc_pages(get_order(guest_size) - 12);
>> +	guest_phys =3D memalign_pages_flags(SZ_1M, guest_size, 0);
>
> There is a const for that:
>
> guest_phys =3D memalign_pages_flags(SZ_1M, guest_size, AREA_ANY);
>

Oh, and with that fixed:

Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

>> +	assert(guest_phys);
>>  	/*
>>  	 * Establish a new mapping of the guest memory so it can be 2GB aligne=
d
>>  	 * without actually requiring 2GB physical memory.

