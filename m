Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717CA2C21DC;
	Fri, 28 Nov 2025 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764321124; cv=none; b=AhMONv8mzIg4vPinybTdpsstZ9UwDeZ/R8Tl7DVyn6XoTx8i5p6I8B/p1ZQv1giVWHG3Gy5+Jr4xlvyy3eAjfV6r13tv6ZAqACZ5km0fr6Dkyf0xCe/UIDqYxgS50flhj6peG6gN8ET84P94SCh7fssZb96OtR8bz3NYTkMHGa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764321124; c=relaxed/simple;
	bh=82qB/1eUwV3iZdGYPHBLziWmQsE+8pHHcoDTqZb6Fq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=llWUh0wFWgVoj0oSy4Vl5RynBjlm63LvSmdkPfdQ1LogBaz+7xeJ5HF/RGpYlCv+la9IT3sqVx5fPqklydF932yAsVN3DqdRXq0jvDrlIj7D8t9lTSJn0AyZUyQ1HJUvkS4XTFHpCzv3o2cGUnoTimAdcyuadwXu3Oiw3lizy/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UmbPQMiM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UmbPQMiM"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AS87tR1012251;
	Fri, 28 Nov 2025 09:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=/MGkGvC2D5jrCnOMSARQ8raLIVYZx4SxdmJXlUqsX
	5o=; b=UmbPQMiMo/4dqQUtcHelIE1b92scIVh5pYtZuWeFpNxWDyqT0UXKQE4DL
	XAKqrpNWa5aYJ8NIMyIbgNleuX5md4jn1ghSXwvmgv8ultxtAtt5lCNK+/zeSN43
	OPU/nMgS2XkTWzJNYdspgGCjE7HPRX0YP8TrG2MwJJTGJBM5l98bkQ7Z7xvPyRF9
	O05M2GuYGAJhPav2eNsCSJqKJiqy1z6TqOv20HktT/m3GaHtC4iqkDMlMw7k2G6h
	ZSxJ8gGJUGaxORwJwQZZSQDKXt1AOZE/ZyphWAujgaBQe3nVrmsSf3EC0WMu+coQ
	ILvFTqyfTEV4Eqj+EsXu5e2Sq46zg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak3kkbxm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 09:11:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AS7uvMt000831;
	Fri, 28 Nov 2025 09:11:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4akqvyc9q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 09:11:57 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AS9BrI228574332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Nov 2025 09:11:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AABDE20049;
	Fri, 28 Nov 2025 09:11:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E8AE20040;
	Fri, 28 Nov 2025 09:11:53 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Nov 2025 09:11:53 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        James Clark <james.clark@linaro.org>,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf/test: Fix test case Leader sampling on s390.
Date: Fri, 28 Nov 2025 10:11:39 +0100
Message-ID: <20251128091139.1309755-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AU5zfL7QdecZ2JvHaJmtK3vir05HXIZu
X-Authority-Analysis: v=2.4 cv=frbRpV4f c=1 sm=1 tr=0 ts=6929675e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=tYKNLRJmw82Eq7S0GJYA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: AU5zfL7QdecZ2JvHaJmtK3vir05HXIZu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAwOCBTYWx0ZWRfXxLxyC4kNOacX
 UFqca2gHhyZqnFFRow57JevVUgJuTuplReJcADf7GGVpBBqzQC5C17Fr1tGoaMswwq2hh+j4m6x
 +shvJcYEnqIlYI4UZ6PKkzk13A8gBadwZ3ng4yAX6UzEU8ALZoodNKoJyhxEZQvlUZmLAV+OuTX
 B0O1H999K0Q0iLnuBWkoKIKkHOazFn/Nu+upKTFxWN7KjJ0tjgH0tLp51gEoKerbyFzDd66XPGQ
 NX9Wcf9H/kJsPsNM0F57KlVzwYb6+D4m9HrSOlulUOYKyOibsjBj13ARuRdft6M+Bp7ypwdyIrC
 umbjMlmMyWIvHvozVCdzWBAKy96Epi6SZGj76TymOGhL8lY8U9FcVdSQ4C8X8W+UJx6RFznXGmn
 w+Ysp+fYRpobUoMQHFjvPF/+jZrR+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_03,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220008

The subtest 'Leader sampling' some time fails on s390.
- for z/VM guest: Disable the test for z/VM guest. There is no
  CPU Measurement facility to run the test successfully.
- for LPAR: Use correct event names.

A detailed analysis follows here:
Now to the debugging and investigation:
1. With command
       perf record -e '{cycles,cycles}:S' -- ....
   the first cycles event starts sampling.
   On s390 this sets up sampling with a frequency of 4000 Hz.
   This translates to hardware sample rate of 1377000 instructions per
   micro-second to meet a frequency of 4000 HZ.

2. With first event cycles now sampling into a hardware buffer, an
   interrupt is triggered each time a sampling buffer gets full.
   The interrupt handler is then invoked and debug output shows the
   processing of samples.  The size of one hardware sample is 32 bytes.
   With an interrupt triggered when the hardware buffer page of 4KB
   gets full, the interrupt handler processes 128 samples.
   (This is taken from s390 specific fast debug data gathering)
   2025-11-07 14:35:51.977248  000003ffe013cbfa \
	   perf_event_count_update event->count 0x0 count 0x1502e8
   2025-11-07 14:35:51.977248  000003ffe013cbfa \
	   perf_event_count_update event->count 0x1502e8 count 0x1502e8
   2025-11-07 14:35:51.977248  000003ffe013cbfa \
	   perf_event_count_update event->count 0x2a05d0 count 0x1502e8
   2025-11-07 14:35:51.977252  000003ffe013cbfa \
	   perf_event_count_update event->count 0x3f08b8 count 0x1502e8
   2025-11-07 14:35:51.977252  000003ffe013cbfa \
	   perf_event_count_update event->count 0x540ba0 count 0x1502e8
   2025-11-07 14:35:51.977253  000003ffe013cbfa \
	   perf_event_count_update event->count 0x690e88 count 0x1502e8
   2025-11-07 14:35:51.977254  000003ffe013cbfa \
	   perf_event_count_update event->count 0x7e1170 count 0x1502e8
   2025-11-07 14:35:51.977254  000003ffe013cbfa \
	   perf_event_count_update event->count 0x931458 count 0x1502e8
   2025-11-07 14:35:51.977254  000003ffe013cbfa \
	   perf_event_count_update event->count 0xa81740 count 0x1502e8

3. The value is constantly increasing by the number of instructions
   executed to generate a sample entry.  This is the first line of the
   pairs of lines. count 0x1502e8 --> 1377000

   # perf script | grep 1377000 | wc -l
   214
   # perf script | wc -l
   428
   #
   That is 428 lines in total, and half of the lines contain value
   1377000.

4. The second event cycles is opened against the counting PMU, which
   is an independent PMU and is not interrupt driven.  Once enabled it
   runs in the background and keeps running, incrementing silently
   about 400+ counters. The counter values are read via assembly
   instructions.

   This second counter PMU's read call back function is called when the
   interrupt handler of the sampling facility processes each sample. The
   function call sequence is:

   perf_event_overflow()
   +--> __perf_event_overflow()
        +--> __perf_event_output()
               +--> perf_output_sample()
                    +--> perf_output_read()
                         +--> perf_output_read_group()
	                          for_each_sibling_event(sub, leader) {
		values[n++] = perf_event_count(sub, self);
		printk("%s sub %p values %#lx\n", __func__, sub, values[n-1]);
			          }

   The last function perf_event_count() is invoked on the second event
   cylces *on* the counting PMU. An added printk statement shows the
   following lines in the dmesg output:

   # dmesg|grep perf_output_read_group |head -10
   [  332.368620] perf_output_read_group sub 00000000d80b7c1f values 0x3a80917 (1)
   [  332.368624] perf_output_read_group sub 00000000d80b7c1f values 0x3a86c7f (2)
   [  332.368627] perf_output_read_group sub 00000000d80b7c1f values 0x3a89c15 (3)
   [  332.368629] perf_output_read_group sub 00000000d80b7c1f values 0x3a8c895 (4)
   [  332.368631] perf_output_read_group sub 00000000d80b7c1f values 0x3a8f569 (5)
   [  332.368633] perf_output_read_group sub 00000000d80b7c1f values 0x3a9204b
   [  332.368635] perf_output_read_group sub 00000000d80b7c1f values 0x3a94790
   [  332.368637] perf_output_read_group sub 00000000d80b7c1f values 0x3a9704b
   [  332.368638] perf_output_read_group sub 00000000d80b7c1f values 0x3a99888
   #

   This correlates with the output of
   # perf report -D | grep 'id 00000000000000'|head -10
   ..... id 0000000000000006, value 00000000001502e8, lost 0
   ..... id 000000000000000e, value 0000000003a80917, lost 0 --> line (1) above
   ..... id 0000000000000006, value 00000000002a05d0, lost 0
   ..... id 000000000000000e, value 0000000003a86c7f, lost 0 --> line (2) above
   ..... id 0000000000000006, value 00000000003f08b8, lost 0
   ..... id 000000000000000e, value 0000000003a89c15, lost 0 --> line (3) above
   ..... id 0000000000000006, value 0000000000540ba0, lost 0
   ..... id 000000000000000e, value 0000000003a8c895, lost 0 --> line (4) above
   ..... id 0000000000000006, value 0000000000690e88, lost 0
   ..... id 000000000000000e, value 0000000003a8f569, lost 0 --> line (5) above

Summary:
- Above command starts the CPU sampling facility, with runs interrupt
  driven when a 4KB page is full. An interrupt processes the 128 samples
  and calls eventually perf_output_read_group() for each sample to save it
  in the event's ring buffer.

- At that time the CPU counting facility is invoked to read the value of
  the event cycles. This value is saved as the second value in the
  sample_read structure.

- The first and odd lines in the perf script output displays the period
  value between 2 samples being created by hardware. It is the number
  of instructions executes before the hardware writes a sample.

- The second and even lines in the perf script output displays the number
  of CPU cycles needed to process each sample and save it in the event's
  ring buffer.
These 2 different values can never be identical on s390.

Since event leader sampling is not possible on s390 the perf tool will
return EOPNOTSUPP soon. Perpare the test case for that.

Suggested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Tested-by: Jan Polensky <japo@linux.ibm.com>
Reviewed-by: Jan Polensky <japo@linux.ibm.com>
---
 tools/perf/tests/shell/record.sh | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 0f5841c479e7..46b96d565680 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -260,7 +260,21 @@ test_uid() {
 
 test_leader_sampling() {
   echo "Basic leader sampling test"
-  if ! perf record -o "${perfdata}" -e "{cycles,cycles}:Su" -- \
+  events="{cycles,cycles}:Su"
+  [ $(uname -m) = "s390x" ] && {
+    [ ! -d /sys/devices/cpum_sf ] && {
+      echo "No CPUMF [Skipped record]"
+      return
+    }
+    events="{cpum_sf/SF_CYCLES_BASIC/,cycles}:Su"
+    perf record -o "${perfdata}" -e "$events" -- perf test -w brstack 2> /dev/null
+    # Perf grouping might be unsupported, depends on version.
+    [ "$?" -ne 0 ] && {
+      echo "Grouping not support [Skipped record]"
+      return
+    }
+  }
+  if ! perf record -o "${perfdata}" -e "$events" -- \
     perf test -w brstack 2> /dev/null
   then
     echo "Leader sampling [Failed record]"
-- 
2.52.0

