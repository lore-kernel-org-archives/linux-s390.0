Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC402CCB9;
	Tue, 28 Apr 2026 22:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777413666; cv=none; b=iOGRJ5d5Xo4RJTWGwIDSmIojDrm55J1sm10EXR8Fks6+wha+IEA+qrmJiigBN3OmlhccNAcGttRmtrsyIEjK0F1B0t+HrKdj4sa1wgtWYlZNnZLSmGrl4KGkQ3ychzBO9FOebnk011EgDVOIB6w0aqbrGcnRlzd17AzibFn0fWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777413666; c=relaxed/simple;
	bh=wNO/mETuDkFy/9MXmM2jK1cwgmlasrUfVpK+tu3GabU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pcj/+xThbOEGDjs7HcuDPg20NriiY8v6kQNuAvwB8xYsChlPaWmchhq3XbyhZMovCYyQVflhZlJ39kQx4TN7FLchvoy/vgiKxXo6jJ/d/k7/UzaiJjZEzPj5orLpJYZZDyu1ishpsD+uJPb9QuF24GRclVYkUwu3olVHeeLuLOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cW01pb9K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cW01pb9K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AA0C2BCAF;
	Tue, 28 Apr 2026 22:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777413666;
	bh=wNO/mETuDkFy/9MXmM2jK1cwgmlasrUfVpK+tu3GabU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cW01pb9KcY/xfA8RFjzwfxM3BcwZ2q2LR0aR5uzXYBgssi6qfBb9TPQEuxfE79Pr4
	 g6jdE75vscoTpD7kmp/mclAceA6fcncG7iFb+8556Id/MQM4kf74hwXEpmvzf/51tZ
	 0N3dBGqOh8hVEJR8q49YUGm2yvbdRFvZWr0AUCuVFOj/sCoGsRcPNgGRs/lEO07KFp
	 6tmkPHOISgcsIf6ioxUH4/KsvkhdNn7K4F52k34Gp4DnzPu244TTXV3yUzANh19mS3
	 /3xNq2n9NY54SmjV3z18RDqVpKgwHaiO9Txnj4egPLKf2bvqmg3ENSsynHaQCMCxeP
	 NiGpN2zo3963g==
Date: Tue, 28 Apr 2026 17:01:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lukas@wunner.de, alex@shazbot.org,
	clg@redhat.com, schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: Re: [PATCH v14 0/7] Error recovery for vfio-pci devices on s390x
Message-ID: <20260428220104.GA258993@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421163031.704-1-alifm@linux.ibm.com>

On Tue, Apr 21, 2026 at 09:30:24AM -0700, Farhan Ali wrote:
> Hi,
> 
> This Linux kernel patch series introduces support for error recovery for
> passthrough PCI devices on System Z (s390x).

Can you take a look through
https://sashiko.dev/#/patchset/20260421163031.704-1-alifm%40linux.ibm.com
and see if there's anything worth changing?
