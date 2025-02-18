Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F171DF752;
	Tue, 18 Feb 2025 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910335; cv=none; b=j7vh7mnCjWqxfVrLo9Bioo277RTu252Q7NxpsECJHG9n+hDGjpEWOlPfSXWnlpHlcd0j/l3gPWnD0Hnnp8vDM1smG3yvxtRY8vLLTszTd3wd+zppdUHb0Wcho73crNn/5I3mmXFm5DyoWemH7uURKBdYW9ICs+R2vW3vNCALH0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910335; c=relaxed/simple;
	bh=e1n1HO8Te3vuVIduSWAsmB68eGN79EQJdQNO529zCXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WKt37P/6nTdsS6zwHTmTCGUvnMmNiqa86+SBIJtDGAkPHAFah8eeAgfEAIj+ghdEmKSiO5eitvhh1qOJDSyguUx3Kzg1NLI10ArcgUuktFifCq1wC2fUllpkO5jpnCAmMth3cjd0pPzgpYs6Wh55n8rj9dzDMsJzj7ePR3baICY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=od0RyUE5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="od0RyUE5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF20C4CEED;
	Tue, 18 Feb 2025 20:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910333;
	bh=e1n1HO8Te3vuVIduSWAsmB68eGN79EQJdQNO529zCXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=od0RyUE5SMfcfE/7phTr8tADefsj+5RTu/4Bd4dBNKK2VGAv2wjKIFXKadJy19DWy
	 rA88tgAKY8anc/LfC5mS2Qy9WPSMsRiDSSZ/PTc7Wxo9EEPv1ZQzD85IoD1yZ7ppbg
	 RQCrUuP6MRqpQiZ3eRXIuRG9AbruutDASWzKWv2nJDK3tYLjtVDxwEtaFgeCzhQp2A
	 EBsUhQ05DTyztGa2hBPfgsITtrFNw9C+y2797w+7LgtVDnqQRLHKFH75pQZXnNmXtz
	 /WItUgmIM5vwM1pVCggn5gE06HsK89NPibgb3pkMP1509mqO+ICYlNmEzHbWibGhaJ
	 9v9khxfMwfMCg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	hca@linux.ibm.com,
	agordeev@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 19/31] s390/cio: Fix CHPID "configure" attribute caching
Date: Tue, 18 Feb 2025 15:24:39 -0500
Message-Id: <20250218202455.3592096-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202455.3592096-1-sashal@kernel.org>
References: <20250218202455.3592096-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.3
Content-Transfer-Encoding: 8bit

From: Peter Oberparleiter <oberpar@linux.ibm.com>

[ Upstream commit 32ae4a2992529e2c7934e422035fad1d9b0f1fb5 ]

In some environments, the SCLP firmware interface used to query a
CHPID's configured state is not supported. On these environments,
rapidly reading the corresponding sysfs attribute produces inconsistent
results:

  $ cat /sys/devices/css0/chp0.00/configure
  cat: /sys/devices/css0/chp0.00/configure: Operation not supported
  $ cat /sys/devices/css0/chp0.00/configure
  3

This occurs for example when Linux is run as a KVM guest. The
inconsistency is a result of CIO using cached results for generating
the value of the "configure" attribute while failing to handle the
situation where no data was returned by SCLP.

Fix this by not updating the cache-expiration timestamp when SCLP
returns no data. With the fix applied, the system response is
consistent:

  $ cat /sys/devices/css0/chp0.00/configure
  cat: /sys/devices/css0/chp0.00/configure: Operation not supported
  $ cat /sys/devices/css0/chp0.00/configure
  cat: /sys/devices/css0/chp0.00/configure: Operation not supported

Reviewed-by: Vineeth Vijayan <vneethv@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Tested-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/chp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
index cba2d048a96b3..7855d88a49d85 100644
--- a/drivers/s390/cio/chp.c
+++ b/drivers/s390/cio/chp.c
@@ -695,7 +695,8 @@ static int info_update(void)
 	if (time_after(jiffies, chp_info_expires)) {
 		/* Data is too old, update. */
 		rc = sclp_chp_read_info(&chp_info);
-		chp_info_expires = jiffies + CHP_INFO_UPDATE_INTERVAL ;
+		if (!rc)
+			chp_info_expires = jiffies + CHP_INFO_UPDATE_INTERVAL;
 	}
 	mutex_unlock(&info_lock);
 
-- 
2.39.5

