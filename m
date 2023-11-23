Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F1F35EF4;
	Thu, 23 Nov 2023 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA4CC433C9;
	Thu, 23 Nov 2023 15:23:33 +0000 (UTC)
Date: Thu, 23 Nov 2023 10:23:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Ajay Kaher <akaher@vmware.com>,
 chinglinyu@google.com, lkp@intel.com, namit@vmware.com,
 oe-lkp@lists.linux.dev, amakhalov@vmware.com, er.ajay.kaher@gmail.com,
 srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com,
 linux-s390@vger.kernel.org
Subject: Re: [PATCH v5] eventfs: Remove eventfs_file and just use
 eventfs_inode
Message-ID: <20231123102349.110e4525@gandalf.local.home>
In-Reply-To: <20231123112548.9603-A-hca@linux.ibm.com>
References: <20231004165007.43d79161@gandalf.local.home>
	<20231117142335.9674-A-hca@linux.ibm.com>
	<20231117143829.9674-B-hca@linux.ibm.com>
	<20231123112548.9603-A-hca@linux.ibm.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Nov 2023 12:25:48 +0100
Heiko Carstens <hca@linux.ibm.com> wrote:

> So, if it helps (this still happens with Linus' master branch):
> 
> create_dir_dentry() is called with a "struct eventfs_inode *ei" (second
> parameter), which points to a data structure where "is_freed" is 1. Then it
> looks like create_dir() returned "-EEXIST". And looking at the code this
> combination then must lead to d_invalidate() incorrectly being called with
> "-EEXIST" as dentry pointer.

I haven't looked too much at the error codes, let me do that on Monday
(it's currently Turkey weekend here in the US).

But could you test this branch:

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git  trace/core

I have a bunch of fixes in that branch that may fix your issue. I just
finished testing it and plan on pushing it to Linus before the next rc
release.

Thanks!

-- Steve


> 
> Now, I have no idea how the code should work, but it is quite obvious that
> something is broken :)
> 
> Here the dump of the struct eventfs_inode that was passed to
> create_file_dentry() when the crash happened:

