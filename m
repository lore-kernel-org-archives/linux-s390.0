Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012014.outbound.protection.outlook.com [52.103.72.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47817335562;
	Wed, 15 Apr 2026 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245309; cv=fail; b=h1qjvYUU/YgpYJ7cx1CoMEJI+eiWrGAhLliH2RYmjeUiDsvpHACqUMuGtNtzaH5qaAEBeRQPU/PQIF0u224ssCe4VdtsjplospP3bjzDGFhaAn2+Bsct78tqnZYsTknlv+jr4bNezyUCQc41zAz0NETkoQxlwex3gymWRteiMtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245309; c=relaxed/simple;
	bh=Hwq0zbbyYBroJJhvDbtaTNwB50gOAMY0b8sgBW1LXNw=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=rQA4aJIanTdFU0edpGiDD3gE2ZgzuvkB/p/ISClZeieoFkB/ajbLJgfV00628gNucthaqJdwMna/Wkdr7SIbVuReLznc8e6E6tzn0zd4yyZBTanoj212mAmwC3wsohjMAk+teO8+RFrYNp4tk7tVMuEwgxHpfm1BPoXtNkVBgeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=i3Vnu3fK; arc=fail smtp.client-ip=52.103.72.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="i3Vnu3fK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQRnN3xb9T8dWdkaIEMJ6UkCjo7tK1lIPVsSm6e22cpZ/5J4HtkEkz+EeII5u+I8o6BG1Pwyu5veXa90bmcKK73/QP21/n92/iS1E05rpwOaC6vqbacM3d/biLOzpq2i+xXtGOayGLvPLnhCLfTXUvhdDkLALb46zQtrRUjEUaKPAX82zMnmDo5RUGHaj5GWPWXenvLyFLvsiS/QUihZzehHGm9jszTGfrHMumnbOE6eqY9s37KqgPZnN0PM+hKqUZgPSRuzfm3j6urCTGKfstiy3WiWDRpLag/SQi6YSwruAoRsPmNsVUl9E37xGZhQOi9YeA/LBkR9OGbSIuEFWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4zGZsAyhpA+AXjFaHF1wzlbipprbvOjCvbIfQKxtLg=;
 b=T8LkRRw33yU3NSpdW4IjlS3s01dJUQK6BfVrGVChcjsa7Mxr8qWmjGeKnbEIS1KT9Wos7FIWEW6MceGdCj7WUekBml5XM5R/ND5vg0LqCx3+4vYitibuL2KCTPrchqHc4LcKIdeqhNeG2Qb+EF0j5pVJmmMpWTUIR3UFb5yVnz+qPqUdeMyPc44U5dQjV8JABWjhWNVML6/eqHo5eE3vmv9LbY/L9gTrsusSd+sAD9hh2B4PTV8T9eARjRbEpIPrlqGlHAq9nIarmENcaTVYTog1o3KwD1/5oE+9FPi2h8PLslUKuY6pFbq3m1z/puTltQcNvNRzSg7mjB2KOcViDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4zGZsAyhpA+AXjFaHF1wzlbipprbvOjCvbIfQKxtLg=;
 b=i3Vnu3fKCsTHtgKcdjr7Eq2k2PM7nQjUCzkLhRiMnZIFspb2Pimum0j7z+CbnGDOP3kG3btUVdXaC1nm6mlCWesLI4iRNT6vePRrkf6DQg9wkD2WLCP2GMcmBpHEkVQc+wGndnTH1/sGt9SfmmtQqnshHs1oXLnk0I5ILVu4Hgh//9cSXPaLrFvE22WRHfApSTAlPqvGNvBfVLqsSiANhTq2/+OXAGpW52RD2WvOKeWwrfJy7KPaBSSADdPifL/+KJGfOsbpoz9Cf0/AMvT73gw89YDEppg5gHh1Rpigq5OFL2udXmjRx7VzOOZ/rq1C9GF/Vy4/qR+u6gvYhKVdXw==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY0PR01MB10074.ausprd01.prod.outlook.com (2603:10c6:10:2fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 09:28:22 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 09:28:22 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Wed, 15 Apr 2026 17:26:55 +0800
Subject: [PATCH] KVM: s390: pci: fix GAIT table indexing due to
 double-scaling pointer arithmetic
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB7881AB7449FEB6B58E4BA6F2AF222@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAN5Z32kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0NT3bTMitRiXYNEM0tLU+M0A0PDJCWg2oKiVLAEUGl0bG0tAOlW4dF
 XAAAA
X-Change-ID: 20260415-fixes-0a69953f011b
To: Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Janosch Frank <frankja@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Niklas Schnelle <schnelle@linux.ibm.com>, 
 Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2462;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=Hwq0zbbyYBroJJhvDbtaTNwB50gOAMY0b8sgBW1LXNw=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGzPuR95y7mdKyGS4qmmxzKfjsFmo5f5/j+fxrM9pze
 c19LOpXPO0oZWEQ42KQFVNkOV5w6ZuF7xbdLT5bkmHmsDKBDGHg4hSAiVw1Y/inKHU4z/53Eo+a
 pYGw28yGw+V7r2R8VWQM4Np8p+nES9apDP8jKlfuZ9608leH/5mAtngft63iZb4yX7sTb9mWBrv
 OMeIEAB58SVk=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: TP0P295CA0043.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::18) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260415-fixes-v1-1-b4e150f6ab92@outlook.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY0PR01MB10074:EE_
X-MS-Office365-Filtering-Correlation-Id: d19f69fb-f15e-455b-1e3c-08de9ad15656
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6d5vbofsfC/jnGJ+j4hG4ECjrcN7bYYbjGziM3RRZalq1liKAk3PcM61URQVNvpPhm5TgOzZsBnm2EwqrM1GX9S4itUfhQT4Fp8B/hHRUy+t4PSSbPbXdv6Xb8GT8IvnG2paNKrtW7cc23RF0SpcOnGZzWU8bsWu8nYlnu5T8itNvR7aTJ/3zaeeeDdH5LD3WVKd2amqDpog0wr5rE3sjGTqffHC8UMk5Y3aa1OUwxr4fGh4RMAwQoeIjbqELavuIL46HgMjtDBJEQ/9dGJPUxAbfi20kjNIixKv6OPSUoksp6dwk+onGB2CxN5AyP6a0/cItI14POLW3bpQYIG/5shl5XIdPUd+x4CwE9+Yk/EtQ9T6M95h9tZUGKK8dgdBjEhG5Mu1zeukpuiIE8UqndMhOPgNrIZJv3sjs7+rlt0tt5h/87pQXKfG6dQHXJbDKRx3Dnbv/uy4MO6lnw8A5qjTE3rC9bT94igZhIoWIl+gVi/BV9ZH5/FJ9Ux8hEkqscqKP0ZF5y0IA5ISG2NgIAPark/Yvv36Zmlx4OEaqwxFHCdhYHiRKxCDgCb9Gz5cptokCSOp8LptbRM/kTnhl5KPIvWgUk4wouzu5WPxwxlDcL2jUQfn/A10xpQU7UF+xYGHGWokYrdCkbXbwNp3uw9KDNKC/micLTZ+uVwkWTa9bXcS04YyDqrWZ2/IcgWId5WYQlNngH8Zq7YWTUk4YkFL2N9hYSLZcLzjs2jb/0zE3NZjyyhw9QKBrhJdQPC0KI=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|19110799012|6090799003|5072599009|8060799015|15080799012|41001999006|5062599005|39105399006|461199028|24121999003|22091999003|440099028|3412199025|40105399003|41105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVRGQUtCM3BuSlUwL2wzOHJrYlNJTDVDcHhNaFFSUmVSRkZ4aGRpMjJTMzFp?=
 =?utf-8?B?S0twR0F0MW4reDhieno2TnZGK0FIM3lQT0c1T25aVzdrZ1ZXQzV3Z1U5ZVlv?=
 =?utf-8?B?WDZybTFMbVFpK0ZueXluMStHcGVqSDlNQ25RNkpwQjIwRDJHTThVUEk3cW4w?=
 =?utf-8?B?N3FmYlJqVHBrR3JkVEc0aGNLVHhwbmZZYkhPNTlKdjhuU0IrNFllSjZ4dEd6?=
 =?utf-8?B?UG5yK3ZaMldxV256OWtoTUR0NndDMDJWaGdqb0JCTUQyQkZNRFJhM25weG95?=
 =?utf-8?B?cjNLNnRvOXNjUUdXbm5pSnltQ1NvYmF6TEV3cUU1S2llRHpENlJ5eVVYSmlh?=
 =?utf-8?B?c0UwUHlFRHBOT0ZXOTdOSWJabWRqM0NJakNIS2xwOTBiVU1qZ0Z2enFpc2JG?=
 =?utf-8?B?cUU2RHQzeVBxbUJPeWxvR3NaZ3MyR1p0ZW80WGZkZTZLWXU5eTNyZVFoZUlY?=
 =?utf-8?B?amkyTDg1UmRmSGV1ZWZuSVlqUzJwdXVEeGlONlZ1ZllPSzZKVzI2RTZ2bndT?=
 =?utf-8?B?azBqbEJseGxiQ0hMVW1uRUhOd294VTRkNEVzdWhwcXZodG1GN0dGYW5YR1p1?=
 =?utf-8?B?VFJmOGlqRlFrajE4L1pDd01qV0ljNmxIajZrczZabXdzZmQwcGFvcW00WnQx?=
 =?utf-8?B?dzlhbGYyN0FVL3ZuL0VFdkc2b1NTenhMNzdGM3NWRWlmSy96eTJQTnYvTDF2?=
 =?utf-8?B?b0dQNzR4c1NQVmxQcjFzTU8wNXk2eHl6eW0zczQxSCtBV3p0cjE3UFVONEp2?=
 =?utf-8?B?Zk13NVlzNjVrMU5QZmpUUUFWWlM4ZEFydzFWUzhlMnZRUkYvWU9PRkNzZitx?=
 =?utf-8?B?VXlscHhQbjBpUEV6NTh2L0xkRm1RVUQ1ZituZ0JUM3lQRGR1YzA4SFlVanZX?=
 =?utf-8?B?QmZmMWMva1VTelRpQ3pqVlk2d2JGajFyZldsZTZObEx3Mis3NjlUWkIzU2Er?=
 =?utf-8?B?SjFhaGJKYjh0RHlmdUlMRkh4UXBxVWg4NUhqd3ZqcnhUakpMVEJkQTlUYkQz?=
 =?utf-8?B?RDZyb1VadmVhQjdsQ1U2VXhoc0w4V0ZqYWtueXQ5MS91NWkxcXFZZXF5T3hl?=
 =?utf-8?B?VVBoaTZpcXdyRTZtRHFOb1VQaHBlNkEvdGF0MWFHbVRVM1lQdm5VSnoySDhR?=
 =?utf-8?B?S1U1bFM2OGYrejJhM25QNG8xSnY4aGlqZDBIQ3FRRFY1TDcrWDZ1MWJ2SDc0?=
 =?utf-8?B?K2plSXRSN0w1QVZEbkJlUmVoMGtjdlYya29HU0YzMTVYZGovN2JuUDgrVFk0?=
 =?utf-8?B?ZW5MZVB3RXN1SkVQOGxMRHVwajBYemI0NmRDa0VIQklHVTM4KzlQQlRseWpv?=
 =?utf-8?B?dkVwbERYdnA2WUpGZUllOE9GdFBYZW9nM0JzdXJTd3BHVWtva0hBNzJxMWxs?=
 =?utf-8?B?QW13cjJ5TWpmekh4VWpXY2RiU29KVTVsRXpCOTVTR1JZQlRmOVNVMkF5L0Iy?=
 =?utf-8?B?NFJIQkdwRVpRdUR6SFBjbFZtQ0xwZTdWZkMvenc5OEFiRENiUVZtdXJJQ1hV?=
 =?utf-8?Q?FA44iNLVuJBG1ZNKW9BRlrAbG4O?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFJkMlFkRHdNVXVWcnRuMFpNbTZQZGZ0ZzRoL3loOVU0NkJFVkE3MzNrSHBG?=
 =?utf-8?B?MFJFNEVJWXpJNm5ucjNQTXc5SDJmalRDcW8zRGtWZmI2OFA0UGtERFgyK0Qy?=
 =?utf-8?B?UUVwTGtQeVpTUXlIOHhnVGtMWmY4RUNBT0lsOFdrQmVyZTdLRC9UdVh0OUNL?=
 =?utf-8?B?SzFBbFp2cmtuSkludklrTW5lUk1aaGlmNUZ5NUlDL0JNZlRYdUJ4Sy92V0lF?=
 =?utf-8?B?TTBCUHdjbTUrWm5wVmNrWE1ieFFXY0hqMlpyUGVWQlp6YnZxNXNVWkxUdDFT?=
 =?utf-8?B?SloxcjNSQlBSek0yam1zVzFVbER1cUxDdTBLajZYbzVpVXJNenhZbS94c2dV?=
 =?utf-8?B?RTc4YWlGY1MwaGMzM2pGdWJsVWdmOExHWG1iazJVZkRqTDZRWTE0djF2Wkpz?=
 =?utf-8?B?cHlsMDNoaGhxcVQ0UEl3OUZWQTFyekRyK092NXB1SVV4L3hPMmxsdVVUb1FR?=
 =?utf-8?B?SjhjQ0hXdXBaRTY4RGJ2ZUZEa3d6eS9YSjRwaDJaelVtaUdDUi9JZ1RublRy?=
 =?utf-8?B?TVRKS3UxUE5PcWk4TEdaMmdZeWd1Y2VWZ2duVEpQUXVzbWFkSjJmMGUvWGxQ?=
 =?utf-8?B?OVVZUzdaUkpTWU8xSVlxUmRNOFpvcWthMWRmNUtSVmJjdWpjVm9KOHBLUExP?=
 =?utf-8?B?NXMrcHV5Kys1SUpHeHl2VmQyMXdGekU5VUhVNVRkUG1qSE5YaDNyN0YyNlBQ?=
 =?utf-8?B?Um1jemphbzgxZDBocWRMTzY0eks3akZPRmovRWNETmNNdHVUU3BPc0M0QUcv?=
 =?utf-8?B?b3E1WVJmaWo2RnN2czdQQnVPOXZSR0RMNEVTTWltdW9RYXZ2SzQ3SVJNNGtQ?=
 =?utf-8?B?MmlNNGMxREVpb2FPalc5aU9XNmF2aFVGS3pXVGpGOEJzR3V5SDZjbjFRbUJU?=
 =?utf-8?B?OGhsV3pCL2VyYzhLRHF6M0NVYWo4ZWdRTEhkNko3Ky93WjVHWE54TzRLdUpp?=
 =?utf-8?B?MGN0b3pISlQ1Y1BoRWpJTmlrUWxhdW1USGRwLzdIZ200MFBSMC9wd1V1czdp?=
 =?utf-8?B?Z25RU3EvM2U4V2JVdmdzMjZEYk1zTjlkZVJtOEMzVktEY21wQXROQW4wNDQ1?=
 =?utf-8?B?eEJzQ2dHaVdWbFhCNU4xZ3l1ODhHRlhpbDlnUnJOcnlNNFVPbzhUdjdoalFT?=
 =?utf-8?B?QXhxVDhlcTBMZjVzM0k5dkY5ei9LRkRKcWVPVlBqYzVzb3dwNnFzdUVmVGZP?=
 =?utf-8?B?UzZQb3VKVXh0MmVHWkFHTnhpeHAxcE9PWVFzR2N6alpyZ3RtQ0Y5Z05XN0Jt?=
 =?utf-8?B?b2FTeXN6TWlvWE1DZEtBUUtVK3V0ZWpxcFpmZytsT0FrRGhVaFplRFlmNzgw?=
 =?utf-8?B?Z1BrNzZuUmI5RTVrYXF4V3JlVGVMdFJ0dTUyTzExQnU3VUdkcHAzVzh1Um1I?=
 =?utf-8?B?UGJucU9jQkFqbjVkNzM1Wi92T05ld1JZcWkzdFZKek1yK2h5YjhPeEZRbVJT?=
 =?utf-8?B?bGZpWGZBRmM4eFZ6c3NmUHdVb3crSXhaNXQ4VUc0Q2tRQkhNeUtxS2h0M2R6?=
 =?utf-8?B?dnQ1Q3NsWUNDY3lyRVBFNjhrS0d4QTJwa2taZUI2bVNPU1NOeFBYVVF1NE5K?=
 =?utf-8?B?enJOa3g4N0UvU1FSSlYybDhnSzF4UmcrWGZNeXNDS1hNbFc1cVJsRVdML09X?=
 =?utf-8?B?N043U3Q4QnVEbko4SkpuZVpqTzVlMlRVRnFjNWg0cXZaOWNSaHg3QkhZcnJN?=
 =?utf-8?B?dVV2Q09meEQzTURsbjZkUGxSZDBqUVV0SWFZRmZUK2YzY1FtNjZvT1ZjU3pa?=
 =?utf-8?B?eVM5L0UwcUN1OGJucDF4ajN3TWJRMHBPTkF4QkFCS3Z3NnBYbGdkS0FGOEhh?=
 =?utf-8?B?MkdGYURLc1docC9WV1EwS2kvYU5aT0JKQWEzR1Q5ZkNja1I4c2h5N0JLbE4v?=
 =?utf-8?B?N0JNOVI4Qm12T0I3NVhpblh4Njh3Z0RlcFJDYUdRN1VEUEE9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d19f69fb-f15e-455b-1e3c-08de9ad15656
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 09:28:22.5552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0PR01MB10074

kvm_s390_pci_aif_enable(), kvm_s390_pci_aif_disable(), and
aen_host_forward() index the GAIT by manually multiplying the index
with sizeof(struct zpci_gaite).

Since aift->gait is already a struct zpci_gaite pointer, this
double-scales the offset, accessing element aisb*16 instead of aisb.

This causes out-of-bounds accesses when aisb >= 32 (with
ZPCI_NR_DEVICES=512)

Fix by removing the erroneous sizeof multiplication.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Fixes: 73f91b004321 ("KVM: s390: pci: enable host forwarding of Adapter Event Notifications")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 arch/s390/kvm/interrupt.c | 3 +--
 arch/s390/kvm/pci.c       | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 7cb8ce833b62..f48f25c7dc8f 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -3307,8 +3307,7 @@ static void aen_host_forward(unsigned long si)
 	struct zpci_gaite *gaite;
 	struct kvm *kvm;
 
-	gaite = (struct zpci_gaite *)aift->gait +
-		(si * sizeof(struct zpci_gaite));
+	gaite = aift->gait + si;
 	if (gaite->count == 0)
 		return;
 	if (gaite->aisb != 0)
diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 86d93e8dddae..eed45af1a92d 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -290,8 +290,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 				    phys_to_virt(fib->fmt0.aibv));
 
 	spin_lock_irq(&aift->gait_lock);
-	gaite = (struct zpci_gaite *)aift->gait + (zdev->aisb *
-						   sizeof(struct zpci_gaite));
+	gaite = aift->gait + zdev->aisb;
 
 	/* If assist not requested, host will get all alerts */
 	if (assist)
@@ -357,8 +356,7 @@ static int kvm_s390_pci_aif_disable(struct zpci_dev *zdev, bool force)
 	if (zdev->kzdev->fib.fmt0.aibv == 0)
 		goto out;
 	spin_lock_irq(&aift->gait_lock);
-	gaite = (struct zpci_gaite *)aift->gait + (zdev->aisb *
-						   sizeof(struct zpci_gaite));
+	gaite = aift->gait + zdev->aisb;
 	isc = gaite->gisc;
 	gaite->count--;
 	if (gaite->count == 0) {

---
base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
change-id: 20260415-fixes-0a69953f011b

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>

