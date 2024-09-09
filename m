Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB161B375C;
	Mon,  9 Sep 2024 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725885729; cv=none; b=KYPOOBS0GvXUym5m5rSANHoK69kgiYpNRWYda8AqkncOCHVOLvbzWtvRt9Xz2ZAco2NEfLFMFqk5qvjseWpTI35dNrymhsvwe1CaCZ4I4zHR7uVuSdwEF6qJl7Z83wPy7lTe2Ye0IMYX8p19om5dx/U7dRM1pWlsirGh0Th7NIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725885729; c=relaxed/simple;
	bh=mD25jgVpSojKYJP1OW7gZeq/SChR/xght2GcqNaClro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBK/NhC/5lnhYDl3O4DmGKUEYqZWeFkTSowhLFsl0jREkQggZ1iNgOoYv5NiqOlvA4hK1tPpFDvSVfe+Y0l5JKKcbvHi9pltsr+eFoWdUGZzB9Gsix8tzoSNzAqc8LswKt59R18ul40lIyol77C4hpLV8e3K1XQSGVcfQwDRvx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W1AAn5Bv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W1AAn5Bv"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 489CNVkW015997;
	Mon, 9 Sep 2024 12:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=16V2SJVT6ZTpGSJTi80TnFaPg6g
	kCcUj/xh4Jk5Q74o=; b=W1AAn5BvawKjMzHhhOtarnyCcQjsO6DUJ3OoI+kxOHQ
	veAzm+itJCu43OaqbeAeMO4BfbqvfZ/2JqZYhl9xgXIjMbBHhdyhjv3DWqSUSukx
	rMBeAZpw7ApMn7FRTgfgWDuWNHRCuvo5fvOSjO/bgekD+qpty6wB8olpPD8SE9Ow
	e2KSk9j3MZaGn/mUQQvZPyqfTtxxzXLUHxpk2TJq3sJSfLGlfJcnOvH03CW2z/j1
	X33mRHz7KKAME0uj3//HWgspsuTDbDHHQk49Tjc9X7sMwtOYy1evyBrksDTVibrw
	QMszK+tbV+uZdW5c3e56+KIkMFtk+fvLyDO199oYbpA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefy9rce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 12:42:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 489Bx7SJ032091;
	Mon, 9 Sep 2024 12:42:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h2nmeb1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 12:42:04 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 489Cg0e832309956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Sep 2024 12:42:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E14C220043;
	Mon,  9 Sep 2024 12:42:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8135020040;
	Mon,  9 Sep 2024 12:42:00 +0000 (GMT)
Received: from osiris (unknown [9.179.0.95])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  9 Sep 2024 12:42:00 +0000 (GMT)
Date: Mon, 9 Sep 2024 14:41:59 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        akrowiak@linux.ibm.com, borntraeger@de.ibm.com, agordeev@linux.ibm.com,
        gor@linux.ibm.com
Subject: Re: [PATCH] s390/vfio-ap: Driver feature advertisement
Message-ID: <20240909124159.11471-B-hca@linux.ibm.com>
References: <20240905124351.14594-1-jjherne@linux.ibm.com>
 <20240906104540.9510-F-hca@linux.ibm.com>
 <d5911cd9-0365-47e8-91e4-f55317b8040b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5911cd9-0365-47e8-91e4-f55317b8040b@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZcBhgBPe0R-Bu7HS4v-Fa07Tm2Al24Pz
X-Proofpoint-ORIG-GUID: ZcBhgBPe0R-Bu7HS4v-Fa07Tm2Al24Pz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_04,2024-09-09_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=434 priorityscore=1501
 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409090101

On Mon, Sep 09, 2024 at 08:02:17AM -0400, Jason J. Herne wrote:
> On 9/6/24 6:45 AM, Heiko Carstens wrote:
> > On Thu, Sep 05, 2024 at 08:43:51AM -0400, Jason J. Herne wrote:
> > > Advertise features of the driver for the benefit of automated tooling
> > > like Libvirt and mdevctl.
> > > 
> > > Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> > > Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> > > ---
> > >   Documentation/arch/s390/vfio-ap.rst | 34 +++++++++++++++++++++++++++++
> > >   drivers/s390/crypto/vfio_ap_drv.c   | 13 +++++++++++
> > >   2 files changed, 47 insertions(+)
> > 
> > Via which tree should this go upstream?
> > 
> I'm not 100% sure. Would s390 next be appropriate?

Well that's up to you to decide; no objection from my side.

FWIW it would be helpful if for future patches there would be a
statement in the cover-letter how this should go upstream. Also
looking at the "To" list of your patch I don't think anybody would
feel like there is a todo :)

That said, you still need to send a v2 which replaces sprintf() with
sysfs_emit().
