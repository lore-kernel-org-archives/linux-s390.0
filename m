Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53886 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408627AbgJPOLf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 16 Oct 2020 10:11:35 -0400
Date: Fri, 16 Oct 2020 16:11:25 +0200
From: Philipp Rudo <prudo@linux.ibm.com>
Subject: Re: Is OS_INFO_VMCOREINFO unimplemented?
Message-ID: <20201016161125.2fcf494d@ibm>
In-Reply-To: <20201013145303.6f99fe89@ezekiel.suse.cz>
References: <20201013145303.6f99fe89@ezekiel.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Petr Tesarik <ptesarik@suse.cz>
Cc: linux-s390@vger.kernel.org, Michael Holzheu <holzheu@linux.vnet.ibm.com>

Hi Petr,

sorry for the late reply.

It's an interface for non-Linux systems for the stand-alone kdump.

But that's all I'm sure of. I'm afraid only Michael knows the full history
behind the implementation. Unfortunately he left IBM ~2 years ago so this piece
of knowledge is lost...

My theory is that originally it was planned to use this mechanism for the
"normal" kdump as well. But for kdump common code "corrupts" the vmcoreinfo by
adding the CRASHTIME shortly before kexec'ing the crash kernel. So the crash
kernel would refuse to load the os_info anyway and thus it is never set.

Hope this helps you at least a little
Philipp


On Tue, 13 Oct 2020 14:53:03 +0200
Petr Tesarik <ptesarik@suse.cz> wrote:

> Hi all,
> 
> I've been looking into kernel crash dump analysis for some time now,
> and I've noticed that none of my sample dumps for z/Architecture sets
> OS_INFO_VMCOREINFO.
> 
> Commit 4857d4bbe9821c8d732cb84455e18e12b3d79add suggests that the
> "os_info" structure should contain vmcoreinfo, but it seems that the
> corresponding fields are always zero, and a quick grep for
> OS_INFO_VMCOREINFO finds only code that tries to read this entry in the
> panic kernel, but no code that would initialize it in the old (crashed)
> kernel.
> 
> In short, the panic kernel always prints an informational message that
> entry 0 is not available and falls back to get_vmcoreinfo_old().
> 
> Is this a bug, or is this interface used by a non-Linux operating
> system that I'm not aware of?
> 
> TIA,
> Petr Tesarik
> SUSE HW Enablement
