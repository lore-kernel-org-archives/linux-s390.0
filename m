Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795766179;
	b=zxMh5xPqQdzUzOJwHE9TE6UR/h95HP09qhNzvq6iN79t/H4zRBnR86YzDyBX9CdDs1nm
	 VdlDESYnIqSH8ub8U+aeZg+99J6DrbXflvL7BvZfUmgXbuv6N/9ExfcezGifl1o1IXSXW
	 s+P2vggkdUc8Nx2OaYYGitSRZFzkZMQvfFXJJZ4MVAerfxuurEi24lMaCm51D2TUr1RlH
	 cjzlchuHgKpXFOBkpnjYXoEOjMS3PjGyQDpUVF0aFhZVS2fvSKnW35VkxrsL+hkyz+b6P
	 CqYQYqn0ddi5GjvS8nRWKv4ZMOGqYMUR9uqX7Nq/15faMrblSd/jcyhoZ9C+7UvZRKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795766179;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=OEYhfHE9enXB01dk4tnqN0vlTTG+1RGB7DTIfMOnJPk=;
	b=XVJ+3/5pUTVz9knVd87IPXoFUwByLqD19/pi453fPWp+6IRsBH5lR9qspDwDgtGuJXdU
	 +fWDq8TgJEz9JM4jynFbHn6Y9h6CcQGsg+x2EMrDcVvnLfdEkL/RPC4LJudVIvX9/owmS
	 QJSVfifB3iehhYtX4HxmrgSyUl5iwfzUst4S1mCO9QTrnbBULkMzfixO6yxOAkobEPUXF
	 9e4cbCqmjon4mSpHi4ej1BbcH4j4K0t5S1K/9DxM7D7XHAPJW5BqEOE9v1sA+jYewMErA
	 VKNfhVUdInNgpmPYf//cTvOwesPNKDmezvwJ8oWf/5M3kbHn7vHSx5ikQBmnqV4XE0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B1ndN722;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DFC606A337;
	Fri, 27 Nov 2026 07:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73DFC606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B1ndN722
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR7YYcX2489398;
	Fri, 27 Nov 2026 07:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OEYhfH
	E9enXB01dk4tnqN0vlTTG+1RGB7DTIfMOnJPk=; b=B1ndN722fjJ0mMyw6KUz82
	jaUpjgTbdnrUuaYQywOSf+KIrDaS6q3J6UiR1+NDE6Agw7cUmF9bR4vnXY8dMg+R
	7eEeLND1iQTf9ElBhcm/y/E9TzlC2d3m3H7zVEiZkAuSMY6/pAIsP5GACzUIHn02
	cKg32D1SIMalEf40npdurK4ruElbWOWcIdssTBeqAWb35B+ykzP5bU26X0QmHGz4
	melKJgw4vqMVlQomZtJRNUk7BRMSc7x/7KWqjxHE40OZiOHizhDHymphPDj3B5cs
	LZAhbZfjzWhKf5engoOrwxPQS61PivIqKydQI/QhlY3pW7pHD8LYB+Nw81r2xAtA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkvseq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 07:56:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR7JPu72384584;
	Fri, 27 Nov 2026 07:56:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5kfa9dgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 07:56:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AR7twHc31523454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 07:55:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EEE32004F;
	Fri, 27 Nov 2026 07:55:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A825B20043;
	Fri, 27 Nov 2026 07:55:57 +0000 (GMT)
Received: from [9.68.16.159] (unknown [9.68.16.159])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 07:55:57 +0000 (GMT)
Message-ID: <a5b3119b-4986-411f-a03a-06b411c07c73@linux.ibm.com>
Date: Fri, 27 Nov 2026 08:56:15 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] KVM: s390: selftests: Add a test for nested guests
 in ESA mode
To: Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Yvan Janssens <yvanj@cyber.gent>
Cc: Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261125165604.3074595-1-yvanj@cyber.gent>
 <20261125165604.3074595-3-yvanj@cyber.gent>
 <20261126153745.399d7f3d@p-imbrenda>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20261126153745.399d7f3d@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAzMCBTYWx0ZWRfX1g1BOUViKCG4
 g9mA6Aoimal4HQUEX3bz8cO/n7fzKFBtbBsJZW4NSiQsDlNzIdxLEP5O0KxFED250pcg1DlTCL4
 tKApZGai6hvwtY2K9DSjhBhM20dv7CmWnluy2R0Xplet4r/IvOkhnfmfIDw6yFgg5yW+GZtPqp6
 Qw2EEH4OeUoKmzWKMve41ZyMwDDWOtubJkpe0geD5LWRqWDikPmK4AS6/tJqtXAd5IgEfpr6WUu
 nqICesrdszUibque086OezrGfno1lMkC20jYBjIGzkfXOWz8jO9Fmn0DKAxiF2C5guQkklRn3jL
 oXd/EiCoLQ9f7W/Vh5MnK59Hx4NozSiCyBMsqPZ7zWwQNSY1XgEaCNf5SxtcQtKD3QxejZBrI0O
 HoEMy4WO490I0p/3unaAweDjurL5wEZa8n5EGm2S9yHJbPO+wgJ73usnTW9icG3r0IH/oTdG0Dq
 uey38MV3RDK9+l/Rp8A==
X-Proofpoint-ORIG-GUID: uIk6UMpsRra3qNZBI-f1678No4fJoybG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAzMCBTYWx0ZWRfXwduMPYmc14aj
 owOipU12odRnvP8JyMnC4lB1jE9P0TvushfJpIaVllV70LnVIFRzmGPTP50V545XOrzn+eYUFvC
 4ne3nxCYIQ4F3TPiGLxIYiSCd8P7fWs=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b093793 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=iT8M5YjzDwDgK0uH:21 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=21vj9_bZOuehJTMdBT0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4MZ0hf_mp1c0CHUnFMQLlcN2CV9_6kdS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270030

Am 26.11.26 um 15:37 schrieb Claudio Imbrenda:
> On Wed, 25 Nov 2026 17:56:03 +0100
> Yvan Janssens <yvanj@cyber.gent> wrote:
> 
>> Run a nested guest from a state description without the z/Architecture
>> flag, with KVM_CAP_S390_VSIE_ESAMODE enabled, and let it execute STORE
>> FACILITY LIST EXTENDED twice. vsie intercepts the first one of every SIE
>> entry to shadow the facility list guest 2 designates and then has the
>> instruction repeated.
>>
>> The test checks that the second doubleword of the PSW field, which is not
>> part of an ESA/390 PSW, comes back unchanged, that the PSW points behind
>> the last instruction, and that the first instruction stored the
>> designated list. What the second instruction stored is printed for
>> diagnosis.
>>
>> The test is skipped without the capability, without interpretive
>> execution for the guest (SIEF2) and without facility 7 in the guest's
>> model.
> 
> which KVM ioctls are you testing here?
> 
> are you sure that this is the right place for this test? my impression
> is that this would be done more cleanly as a kvm-unit-test

We are explicitely testing 2 levels of SIE here and one level is a private
"hypervisor". I think this would require some changes in kvm-unit-test/snippets.
So in general I an fine with taking that via selftests.

Janosch, any concerns and opinions?

