Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.137
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795626303;
	b=rMTsZb8blWk/Ew92p7iO8ve5S9wKY4BRnJvfyey8aZFQSRhFBxnLZ8OtKDNDeAGiba3v
	 FQLuAykuwQfhPLI8SQwz2QIIId9XmeOFdexeCZl7x0ryZXhFw/c+rqF9GxuCFeypbAeQi
	 y7Fhku5XsoRIu14Pp8XwCII4cJfkfYH79P6F/NG1rki7Ia6v/aqSPMzuStf/TOneKI3YU
	 pP8mi4I5KnO0ZyWl/Yva+Jy6o59yk9A4r1qGi0pai6B84W4Yk6CLbrcLrXQyCChACq9ye
	 eWoZNoPDzpIyf9LsG2YCgxd9sVbDk8MwjG0EmRlHtatWx/1M13+PZi4AF/QzIUZ3gbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626303;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=XffW3Ja8w88QswejlBWNoyj5CnT5rn2p+jAe/TZGwLI=;
	b=EBWnV1eEynvk4ZUvJ+iGKldiUemsYO1DbBJpC0h0w+PTbpLtBKMHMKuUsKG54Ff+O7TA
	 LRlH6V0w0dXsxkVC8TyYLwiuv5o3CUJY5M2Ot4Z9PCKfeq3SAYeBloAkZ3enA6Kj8buoN
	 UQEkeKFtkk/jSziSmmKaymuUD6TQ5/rP9z1kjjpRtz1jrWJiiAAuyMsSXvKKSXEgoPB1u
	 qxMe3fK0W1ihYRi88JR4pWyxr03nML9tG5tL4qhJZNgNvgJ07mGkd4cBjTuPN2fR5c2lZ
	 +55BiEctKlBP7nFEub+Ubfcu5ROT7Nbr5z8bpTgZEriVW9fq/PmOR9laECtaaz5xkmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyber.gent;
	spf=pass smtp.mailfrom=cyber.gent;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.137
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023137.outbound.protection.outlook.com [52.101.83.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CB0606A326;
	Wed, 25 Nov 2026 17:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24CB0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cyber.gent
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyber.gent
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwKHGjamdxWcXqslVHaPpH0Zxb3gCx4ZrBmANVSwm5L6Sxm0mzmFQ3m+w9+WQQH50buz2ZvEpDs7WPKL3iygQWMY06matFy+OHsuJHPK2TdpRz+0XxFFgluGJ0075tUq2veSQ7I5IiYk3xVTYBshCa2ymGpp32MykSbYw7au9SzFW5OlFXGsLujGdkD5YpS4C4/oe/iA/zNbOf/wcVSODwvkyCT9XB1NUAAgp9ZNUt9R9ZYDLpcw23K8GN2G7tnVnPk3+9urutPZej4xue/FsVVHDrN87pyH6qq5l54gq95nDi7NXKynBI8hfVPowo0EM9SZN+njXRYF3tIHf43jFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XffW3Ja8w88QswejlBWNoyj5CnT5rn2p+jAe/TZGwLI=;
 b=frCTOPXmKbCg8/jI+Gqcsvjk+RAVJtpCI+5Knq07N9oS0wTh71mVYpCQqrYKDwsyBAi6J9fuB1gUOpSUqBw9Pi0Ykm1WReqFL1ZSigs/+22+cjWsT+K7id96XAwzmhWg5OK3/vNpcn2vpEUyfGaFiFF9dOS+qrzEB1PYzpyXrpHl1F5KLgs04zWISJL8KCOfd/5G/PqBfEl8/4qfaVRpvWkUqjX7JJAJAZUi90Igca6GRaf5cT2UrwSwSfl4IVy+kO9tnbkfEqIy5t3+HG7iEngmG/x7h0BV2bFcBETseW2Doeltv8MGMZZHIg7/wsH1hXpy69VmF+jctjKsz2yqQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cyber.gent; dmarc=pass action=none header.from=cyber.gent;
 dkim=pass header.d=cyber.gent; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cyber.gent;
Received: from AM9P193MB1508.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:2fd::8)
 by MA6P193MB886245.EURP193.PROD.OUTLOOK.COM (2603:10a6:250:53::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 17:04:59 +0000
Received: from AM9P193MB1508.EURP193.PROD.OUTLOOK.COM
 ([fe80::e7cf:9c42:539d:452]) by AM9P193MB1508.EURP193.PROD.OUTLOOK.COM
 ([fe80::e7cf:9c42:539d:452%2]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 17:04:59 +0000
From: Yvan Janssens <yvanj@cyber.gent>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Eric Farman <farman@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: s390: vsie: Rewind the PSW of ESA mode guests in the right format
Date: Wed, 25 Nov 2026 18:04:56 +0100
Message-ID: <20261125170456.3077577-1-yvanj@cyber.gent>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f64f9cd9-e2c9-4821-9d37-6c6ecdcb5239@linux.ibm.com>
References: <f64f9cd9-e2c9-4821-9d37-6c6ecdcb5239@linux.ibm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0023.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::13) To AM9P193MB1508.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:2fd::8)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P193MB1508:EE_|MA6P193MB886245:EE_
X-MS-Office365-Filtering-Correlation-Id: a93c6bf7-4297-4d68-8c1b-08df4b163cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|1800799024|366016|376014|7416014|261026121527099003|261022075727099003|261026140227099003|261022105027099003|261028144727099003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6IJxOCPMoyn+rSFMYo41Wv6p0QYpFUcQw+XsMJRXky9HwRAnBdgr9w9dZRJiWBMSXTqfch4XgsL/3Tc6oZ67uzvuSwd4avsnPDHXh390C2U9X+CL28SxumVxMB49UfCqpyyRgqF6ju3fbc+tzkbCq7XXz4GGucCa3EuxF/zM6Qw08/m8SShXpaoOSL9NH5P+fJ8kDkbiHY6bOfnCiXHXtpml0Mjo/uEcoZpPEEKcFPvlgUpAf7D9lYslVwnhbyYawV8oW30GfjSz4rqiJ2k/0WHOFtegyQQIn3PMZQcOT26AqH/TmmkuYOumTvFHwsAvpfE1qoLZqgsqLbFERzJbOQ0kUTOtPeNSXjaODTo3mH7U3hL/mhMh9Vrm6JLr7udrSAeOKzR15GjHwH8uSC8Xbm8+CTMNksioeIuI+66NGyr5BHrK72NcLL3mF3VvtIB/P/joY22qClSJ2WAcWskR/ksJcpZLzWHtOWCNqZzQmxKJ3ze8aKvOAUKLJJwWqqy+izViyVjDHyOWYeYJ4DVgTzTkGe68YHSGwsFurUjUve+EuFAANPscepXDTiETLad64Qpor75BWo8hUH8jXQooLoFzuYeiOyYeUEstT1vKoFb8kd0War/e3SaGpkooZ36C/DFYbQNiKliGbPzb+2ZSv6yOZPvxzYJFPq33xMrYe3o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1508.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(376014)(7416014)(261026121527099003)(261022075727099003)(261026140227099003)(261022105027099003)(261028144727099003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vJqgR/DOmOomcZHGHfPpYt31qQH6nyDTafHUpylpBhX2qgqHh7Bqkhjc84Hl?=
 =?us-ascii?Q?RNLy+cYZ8zMBA4p5sno4kucLfsYjeP8tPNspL/6wJAKT8t6fVkCS3a67v6Ul?=
 =?us-ascii?Q?9Ou77NerxOSnSjZQd71i35KPTMsRYlSvNRIgZyaoJzN5uZxq9lGeoaNOA4ws?=
 =?us-ascii?Q?8KbQglzBBoXlHmfGQxbEkACSZZPy89UIT7l4MQarPGSjdY/qXsyKsNsQQ3SB?=
 =?us-ascii?Q?N3a3QjOoB70TMKYbLwhWyzcDgtb7F70gcLKg3fLy79zb+YayaD+s7vI21yYc?=
 =?us-ascii?Q?WZfpF9oaAOXVQRpZxfPALIQCQQtYoWxFR/KFOJ97KIicoUY2afqdzapwwMnt?=
 =?us-ascii?Q?v825FnVJ5hf52zQmaN2guHC4S3nmrz/OUdSfuPCcu9vppehyVwmJMv4NyWB3?=
 =?us-ascii?Q?X86j0JxV98h0k4w+jq0qJjXzcBgFaoHyTo1qX1cM0CCto0ZUowA3u8PRD7Ho?=
 =?us-ascii?Q?dsiCc5wufpvC5h0ssPTS2KsvopDIZRVHITv48PWynGrzve/qApNugOO+YkSJ?=
 =?us-ascii?Q?0ROS20I/BPB5wd+5I0u9Su1NWveaA2drY1Yd/fYebpDS4cwMC92VY8CXc/VU?=
 =?us-ascii?Q?gZ8/5A3b9jPdnZiwNjUfQaO1126iaH7OAGUVoASU3GZ+gwnYemq7SJAPSyJw?=
 =?us-ascii?Q?sTrugNSxQaFrxZpwIWaE+x4RkFaA7jc8Zd7mZ29IxZw5vw4jsZjZ5O/BKBaZ?=
 =?us-ascii?Q?TIITANnqWaxQ46+5sIPJMS1pcvlJA5NHHmvpk8CwAUutG+qMt6mYaGcQoCQx?=
 =?us-ascii?Q?MSic+TbvVkxG8jX9jCvnssouOHlvv7F6h4+UmometnY0DWdpMJIlJYc25UQ+?=
 =?us-ascii?Q?RvXr6Ewt88ECVfEikVlHrIV1Sht5TESsD/9Jw0/1eAcVvq3OvmtjdY9f+SNS?=
 =?us-ascii?Q?VYShSDiWJgcZrRmEY4VyzODnEB+ufYaoHWahMsUauYJFZOIWEqw6urzFB7n7?=
 =?us-ascii?Q?mrS9Nvkha3ADz7zLWK0v8mRXeF9LFY3GWRAdKmFpE/ruh3lUtYOJmdYO4Vdj?=
 =?us-ascii?Q?hInTTH9fbYtNxkSWBpwOdQPdZc3WhZ5VbpTG2vkBRhffk6Fd1WKrgzThQdX3?=
 =?us-ascii?Q?oIE5rt52l6vyOpvg6+dfqrD0tjB/3pHCbUe2IKaSWjwmFx8+xP02LhO9UHR+?=
 =?us-ascii?Q?bj/0JtBjrdWqgL9ffVMYsWEnaQa7hxpCEQbFRqXKCEnEufcm5wOHw43RaTy9?=
 =?us-ascii?Q?Y6C+/6JO6yUnIiyijXT3t4Tqhc6dDjcbETLTnaCK49EtrN85/QJ+awX+qy3/?=
 =?us-ascii?Q?oXZTpQiKT2BoiC34AxQsuSyrl3sc8xuboJpjmhqfMK13dX+pxXqNM3m8yogh?=
 =?us-ascii?Q?nGvYgSoRDGxdm3MU3CmldxsQ7UxGdK0L8cniboGFeDydeR6JxJgZRtP4LkfZ?=
 =?us-ascii?Q?U57vvZ8W30tKdPkYFx7fgPyJyrhzhSKHeaT/9UXesTBJscuERhhdoQynOoZW?=
 =?us-ascii?Q?cDFgqtpINcqP2JunGyrwgpgjoGCFt8UBgYWJngTyZh994cL3OH98v+YWaVEO?=
 =?us-ascii?Q?a3nkNOewSf4Vw67SEUuRDA/+z8mgCcM7Z3Cm3yZmfgIWHaIf4FjRiKnQ/hal?=
 =?us-ascii?Q?P5r5Fsx9ZxSGUo8It5X7fbf4hR86S8/No3Ju8+503s9aNeytIe6Mxg1oBrF3?=
 =?us-ascii?Q?yiEMhEfGNcObrNFbMURKB9exQMJkS/R3mgIuB1YcPEed1eUa3ILkm9UhSunK?=
 =?us-ascii?Q?pDoKlVOBmTBGWFdNxpC2sZreXI0GdNYJcyNTgLjNYEVSSDWBX8oWbhEeShI4?=
 =?us-ascii?Q?AubYwDUR3YEGTZUaFj+eM73iiMPcb+bQ1w/7TixhSYRSySZMXq6h?=
X-OriginatorOrg: cyber.gent
X-MS-Exchange-CrossTenant-Network-Message-Id: a93c6bf7-4297-4d68-8c1b-08df4b163cc0
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1508.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:04:59.1677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d5a0a0d6-18b4-44e3-8e5e-e5dbe37f9ee2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o97wiUM8E2EtbiO1BXqRORHrPfwtqW+tbZ23nEi8bRzMPowHjsB6pWc6+P3qTyNp8Flq1sm14h7hL97LmYxeqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA6P193MB886245

On 11/25/26 5:19 PM, Janosch Frank wrote:
> I'm wondering if we should only copy the a DWORD back to the guest for
> the PSW in ESA mode and not the long PSW. On the other hand I'd like to
> have as little ESA accommodations in this code as possible. Sigh.

With the fix, vsie no longer writes to the second doubleword, so the
full copy-back just returns what guest 2 put there. I'd rather not add
another ESA special case for that, so I left it as is.

Thanks for the review; I've posted a v2 that addresses the commit
message and the comments - it should be on the list.

The new cover letter also contains the rationale for this work, and this
might be slightly OT to discuss here. Feel free to reach out directly to
discuss it off-list to reduce noise.

/y
