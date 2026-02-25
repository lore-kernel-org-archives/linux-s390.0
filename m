Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900703D6467;
	Wed, 25 Feb 2026 15:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032102; cv=none; b=rn1yBTmtCKMZP/kIjQFELIZpJz/v7ZhnWzzr+IMH52lRO+C/wNY37Yug/uyo1K9E6XtUMz3kyIIyTwJ5ZOs37Ctzh7u/92fxZ3SPx6/cSe8ZDpnjdy5Z4AShheIehtDTJdN501aKNsUfBdUXYHSbHHZeAubV+irYgmYEbpE/hFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032102; c=relaxed/simple;
	bh=Ck3kgaO6Ci/MpvhfgbTbNUTuxLJzeZAAma/C1aQKzK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kqBiIutVEIvMSYsZLHwU2hJWK5E0T4Tgf6hlLSRocDpftoeNvBDT6syz2P/A6uhxhvNzZgiNihRLKEJBDww2p+OD13X/TSDKbiWWjRm58eqjkf3R6Fcv6cAOaITCT1yue5FWiI3OYCMYc1LpA4MXtlMrT+RhY/IOCFq7+P5GYBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XW6ECnin; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XW6ECnin"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PDcEgb2839736;
	Wed, 25 Feb 2026 15:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=DN2qxKaJHDjLmyJwpqt3/I5xiGmV
	jrQ2aD6U5XPHe3Q=; b=XW6ECninIuvng6TcNGlStrB16MmQlXAcvPBdbYRARzYj
	Xa9AALo5pD0AcMrFzGcGeWZa/YZiUVjWUlQo/y5XISxU9CCcbYg8UoKxBSlKKXoV
	GwYdZ+PQQrWYu6TdOb1CXKC7ecMHDl33TA71rkwg+F8KlUo34eF8Y9zJW1Lz65DL
	yic5OoAE0SBaB7bdrlhTc6PDrD3KswctOTj/y/xcWMjPQzA9sGq8A5DX3VcuCSZ/
	wPT/6UVbqhvXmEzJSwHvc3/1eXSwUba/m3TZwSLDXzxSbPlrRO8i8Mj4vmKdBIsd
	ZLtv9h7vySQ4UnpgMCGU5+Ax4ksPZWluYAOVsCFsaw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4bs00ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 15:08:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61PE2J2N027887;
	Wed, 25 Feb 2026 15:08:19 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfsr1whd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 15:08:19 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61PF8I9D19202642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 15:08:18 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 055725803F;
	Wed, 25 Feb 2026 15:08:18 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C71A58060;
	Wed, 25 Feb 2026 15:08:17 +0000 (GMT)
Received: from IBM-GVXK264.ibm.com (unknown [9.61.246.19])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Feb 2026 15:08:17 +0000 (GMT)
From: Ramesh Errabolu <ramesh@linux.ibm.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>
Subject: [PATCH v1] PCI: Add write-only 'uevent' sysfs attribute for PCI slots
Date: Wed, 25 Feb 2026 09:08:15 -0600
Message-ID: <20260225150815.81268-1-ramesh@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 8pKqr0hWamVNxYJGp1-iNglwQ2zC0qqZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE0MCBTYWx0ZWRfXxTcyUwYGICiH
 vKm1K1x8K6xn+K6ASUspFt24ZOkpueM1Ek6Unn6P1B/hPmGjwQoY3XaTgcunm1ceu0+OQ3CfvKZ
 4LKXIqrgJBy3pUiq63zTfA0Oa+NjlTXIfNC9h4sNthpqar85kdvNVogqQS7UaCN4Y5rJ6Sj+YJL
 QAcS5HOSWmz7f7tc6Pm/ZGKOHKcjN0T3Ylmct+vrfGKkxogwzztjxtCM08FB0ttaC61iBuE8V39
 sLLU8Vd84NAUYepURoeIirHpTr9flczEkIlo91ZuxzELtbroBOBhdqinvXIEFmoSCkk66BM7/H1
 uIrdglAfs2sH3iyLAWO2n8uzICD1rCQNPtwwcfcpxJFH1Bg0g0Z8DaJFfKJhKwPtkmfhr0YSzOg
 eS4ZsyfzU0Ojoe8QqMcFZpdVllKqND76Gf4l3wjunsWZuuHkWt/5Dxgwt3CowjZXrTOsh+wdXKH
 ZsBusWn0ydKk43CPLng==
X-Authority-Analysis: v=2.4 cv=eNceTXp1 c=1 sm=1 tr=0 ts=699f1064 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=QnXZM0yobw_ZnC76DZAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BpcNKJTU_RagYjF4SCSIw6K9fhmBHunA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_01,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602250140

Add a new write-only 'uevent' attribute to PCI slot sysfs
entries. This provides a mechanism for userspace to explicitly
synthesize PCI slot uevents when needed.

For cold-plugged PCI devices, slots may be created before
udev is ready to receive events, causing the initial 'add'
uevents to be missed. As a result, slot specific udev
rules that define naming, permissions, and related policies,
are not applied at boot. Allowing userspace to resynthesize
the 'add' uevent ensures these rules are processed correctly.

The patch was validated by manually triggering PCI slot 'add'
uevents through the slot’s 'uevent' sysfs file and confirming
that udev received and processed those events. The following
command raises an 'add' uevent for a specific PCI slot:

    $ echo "add $(uuidgen)" | sudo tee   \
                /sys/bus/pci/slots/<slot-id>/uevent

Signed-off-by: Ramesh Errabolu <ramesh@linux.ibm.com>
---
 drivers/pci/slot.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 787311614e5b..cbc7cf6ab7ad 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -63,6 +63,15 @@ static ssize_t cur_speed_read_file(struct pci_slot *slot, char *buf)
 	return bus_speed_read(slot->bus->cur_bus_speed, buf);
 }
 
+static ssize_t uevent_write_file(struct pci_slot *slot,
+				 const char *buf, size_t len)
+{
+	int rc;
+
+	rc = kobject_synth_uevent(&slot->kobj, buf, len);
+	return rc ? rc : len;
+}
+
 static void pci_slot_release(struct kobject *kobj)
 {
 	struct pci_dev *dev;
@@ -89,11 +98,14 @@ static struct pci_slot_attribute pci_slot_attr_max_speed =
 	__ATTR(max_bus_speed, S_IRUGO, max_speed_read_file, NULL);
 static struct pci_slot_attribute pci_slot_attr_cur_speed =
 	__ATTR(cur_bus_speed, S_IRUGO, cur_speed_read_file, NULL);
+static struct pci_slot_attribute pci_slot_attr_uevent =
+	__ATTR(uevent, S_IWUSR, NULL, uevent_write_file);
 
 static struct attribute *pci_slot_default_attrs[] = {
 	&pci_slot_attr_address.attr,
 	&pci_slot_attr_max_speed.attr,
 	&pci_slot_attr_cur_speed.attr,
+	&pci_slot_attr_uevent.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(pci_slot_default);
-- 
2.43.0

