Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0740E3AB29E;
	Wed, 12 Aug 2026 20:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786568099; cv=none; b=roZv+ptuOu46N5NdV7Mekub8CW5ImLiqCrwxwEGMx+3jiWaFi9tIH83UsEmTo72XkNiDtBojnGvuGSq1oQ/snqoPOK5Qms5OwwDak7GBwSCPnZVoXKHHabY654lFN86wQfZn9h6BCavtwNVf6/rfrdyciXldR+RAVY+r6PsApIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786568099; c=relaxed/simple;
	bh=RBgmZx5W5XTCdjY7SkY1E1McKukoOV/oaHCHgAt8DQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WMP9zL7sOwlWxEQuuuec8+2fZgI01gx3xKefL9w5VxtjubFDh+GMttJzwaUDzu/N/UUs1VcXDhf+PE4oyAX5ZLOiN56P8Q9Oa9miwOQtbmgu7J0yozwe4cXKjgYokni8lo82WVuBZME9AM1EKAIyTbMtOL0YiGAF1m5dm+SSut8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V7p9kvcS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V7p9kvcS"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK2e0r291749;
	Wed, 12 Aug 2026 20:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=REtpvE
	vIMNJ9hjkK6JevTlaZXvmRDuv01B0CiK1UD+U=; b=V7p9kvcS7qQ72AfX879M2G
	sQQhTPpV+iYN3lkRABL9S/Iu4REbK4v+NgeK9SPoRayLqZIMdxtqBBEXXFRRYE2y
	ZskE3RJo63t66b2aUDWLzdlDvyGYAQzb2a2zMF1HjTGKsVCnwJAFxABcfuAssvLe
	P5XfOiWbG1mVfoF2iGyfKkdsEauBnQxq8exPhGeDo3inK5AL3ROG0kfr1cwuPVM7
	m/DNKb3AWPLjQIam41+iqQwgfKZTS6nd0ooHtjgYFvRXVqitE9moTjRpxVPANYVh
	oQZn/KLEEdbf5G5b6Hcy2zz0kylAQah4Fv44LKW/OtZhvEwvCjeLKhuDdFzLgGjg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9vrsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 20:54:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CKfICH024656;
	Wed, 12 Aug 2026 20:54:45 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq85y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 20:54:45 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CKsiPi25952784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 20:54:45 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC0D758060;
	Wed, 12 Aug 2026 20:54:44 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6ED758056;
	Wed, 12 Aug 2026 20:54:43 +0000 (GMT)
Received: from [9.61.74.89] (unknown [9.61.74.89])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 20:54:43 +0000 (GMT)
Message-ID: <913258a5-7211-4efc-ab34-72fce38ed17e@linux.ibm.com>
Date: Wed, 12 Aug 2026 16:54:43 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/9] s390/vfio-ap: Fix NULL deref in status_show()
 during queue probe
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260812200240.818004-1-akrowiak@linux.ibm.com>
 <20260812200240.818004-9-akrowiak@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260812200240.818004-9-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE2NSBTYWx0ZWRfX95sTmbwNKP46
 4vvXE8we3I/cbF8wLIDessMCV61bkJhaaFMBYjczMqYTdADzXN05waMqo6ZlxXcUpOD3JsgKobI
 1lBFh126mBsCNbAS5hMpY2NzR2Fx06QCC3x5TS1lDJOK6LfLB5fhQoxu5a8oDMzvSlY2GchqqyX
 a/SmLqgw0xhBhdVTKUjfrGiQqnTMP4Zjbx80agDGdtRNDxMou7nSI3rmwSpMgPSW/IJSIhIbse6
 jmOse2vdxXAj0gf4TRFHz1XvX/uTsxcMqazJZquqwnXGQpHEe8dR+AEO9lIPrqXBDzPOtXzNUWN
 ethN+fVlP+670s7ldKlrT3GkDkufGtSlGt0aa8WhgipqQN4mnTrohDECHla8OX9uCiLWqoEJxPg
 b7nPRhTC77Y2rt/ijLR8yk/cDeOnNB7JeTzGzxMGtp5ntzPK2gkThB0xMVAp8yarnuUrN5aubhR
 EH8S89RrpbJLrNEh/pg==
X-Proofpoint-ORIG-GUID: _UpAGCbV2nlfMh-3KC8oqwVJxh4QnV_I
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE2NSBTYWx0ZWRfX2O8w65OffHjI
 r5yGmDZ8YjK4htl5b4fb6s1AcNv4XcwcMY1SNb5Q+FBv7/kGNzPXsvZRcFQ6XZD2oyNPVdpgXcq
 vN5a3OAgvN4ZbE0pVtizn1XwQofW8/U=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7cdd96 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=3ogWLBYsyzpkYmsBJL4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _UpAGCbV2nlfMh-3KC8oqwVJxh4QnV_I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120165

On 8/12/26 4:02 PM, Anthony Krowiak wrote:
> When vfio_ap_mdev_probe_queue() creates the sysfs attribute group,
> the queue's driver data has not yet been set. A concurrent read of
> the 'status' attribute can therefore call dev_get_drvdata() and
> get NULL, which is then passed directly to
> vfio_ap_mdev_for_queue() where q->apqn is unconditionally
> dereferenced, causing a NULL pointer dereference.
> 
> Fix this by acquiring the update locks before calling
> sysfs_create_group(). The status_show() function acquires
> guests_lock before reading the driver data, so any concurrent
> read will block until after dev_set_drvdata() has been called
> and the update locks are released.
> 
> As a bonus, the APQN no longer needs to be read from the queue
> struct after allocation — it can be read directly from apdev
> before allocation and stored in a local variable, which is then
> assigned to q->apqn once the allocation succeeds.
> 
> Fixes: 260f3ea141382 ("s390/vfio-ap: move probe and remove callbacks to vfio_ap_ops.c")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


