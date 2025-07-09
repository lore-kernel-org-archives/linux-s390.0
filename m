Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B3E23B60A
	for <linux-s390@vger.kernel.org>; Wed,  9 Jul 2025 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051592; cv=none; b=lI6gkrFtxFNAWCYJpVz4DoV1da5q0WUhmKslEoge8N2BDZBafR1aewq43w3aJLsaXB0asbKVoCcQ+bBFASdqnPKCKYOHAFCA3AlE7aVkgTGAhU9o+vOS/IJpX99MtBwUQS5X8Iv8MuZA9uuwDsU5M3w9+TIM/T7VKf2qAQ8+f+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051592; c=relaxed/simple;
	bh=OJDk6NXkgOS4rYuphhuWOiGJzUsKnXarLVu1X6m+Dnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bEtPNtkhx1fgDvLyuPEVhWFM27rGtDSIjxil3y7/0O01EfqjE/x5tsjWy9h7JE2zTeVKkRzJu6/nwrK15TtVlVbJ/hGBkorlSi2PA2/D19mvQeBuz5D67Mi0i+Cs5CV6LpSZYHl9cdIseGwdPsfrsj70jW9j4KMMUPiH8SVfOPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tdtyqw+c; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tdtyqw+c"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752051588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yTfBgccmqF02XUI7CNoSoYg/zZ+mYEGteK4oITksHe4=;
	b=tdtyqw+cfwo4jBFr0bilc+QXfSS5JmZ2c1Qlaqy8V91vLQAYGMqCrtJlzER1HoyUQVMc/4
	rWPrsBfM4HWAdVK1hidIXsv/v5aqKW/nnOPw2Ibg4v5KxtsdcjtT9a2OeJ5ZS1hVTogIKF
	oHx1+H94ep4aRefuUzlCtcxSIzJTJuA=
From: Andrew Jones <andrew.jones@linux.dev>
To: linux-s390@vger.kernel.org
Cc: frankja@linux.ibm.com,
	imbrenda@linux.ibm.com,
	nrb@linux.ibm.com,
	david@redhat.com,
	thuth@redhat.com,
	alexandru.elisei@arm.com
Subject: [kvm-unit-tests PATCH] s390x: Fix arch_cmd
Date: Wed,  9 Jul 2025 10:59:39 +0200
Message-ID: <20250709085938.33254-2-andrew.jones@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

As commit ("scripts: Add 'test_args' test definition parameter") states
in its summary, it adds another parameter. Make sure we account for it
in the s390x-specific arch_cmd as well.

Fixes: a7794f16c84a ("scripts: Add 'test_args' test definition parameter")
Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
---
 scripts/s390x/func.bash | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/scripts/s390x/func.bash b/scripts/s390x/func.bash
index f04e8e2ac0a7..28c3a70c7da9 100644
--- a/scripts/s390x/func.bash
+++ b/scripts/s390x/func.bash
@@ -11,15 +11,16 @@ function arch_cmd_s390x()
 	local groups=$3
 	local smp=$4
 	local kernel=$5
-	local opts=$6
-	local arch=$7
-	local machine=$8
-	local check=$9
-	local accel=${10}
-	local timeout=${11}
+	local test_args=$6
+	local opts=$7
+	local arch=$8
+	local machine=$9
+	local check=${10}
+	local accel=${11}
+	local timeout=${12}
 
 	# run the normal test case
-	"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$machine" "$check" "$accel" "$timeout"
+	"$cmd" "$testname" "$groups" "$smp" "$kernel" "$test_args" "$opts" "$arch" "$machine" "$check" "$accel" "$timeout"
 
 	# run PV test case
 	if [ "$accel" = 'tcg' ] || grep -q "migration" <<< "$groups"; then
@@ -35,5 +36,5 @@ function arch_cmd_s390x()
 		print_result 'SKIP' $testname '' 'PVM image was not created'
 		return 2
 	fi
-	"$cmd" "$testname" "$groups pv" "$smp" "$kernel" "$opts" "$arch" "$machine" "$check" "$accel" "$timeout"
+	"$cmd" "$testname" "$groups pv" "$smp" "$kernel" "$test_args" "$opts" "$arch" "$machine" "$check" "$accel" "$timeout"
 }
-- 
2.49.0

