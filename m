From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] perf trace: no longer require auditlibs if syscall
 tables are present
Date: Mon, 11 Dec 2017 10:35:48 +0100
Message-ID: <20171211093548.GE4369@linux.vnet.ibm.com>
References: <1512635281-20733-1-git-send-email-brueckner@linux.vnet.ibm.com>
 <1512635281-20733-4-git-send-email-brueckner@linux.vnet.ibm.com>
 <20171207175352.GH3173@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171207175352.GH3173@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Michael Petlan <mpetlan@redhat.com>, Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Dec 07, 2017 at 02:53:52PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Dec 07, 2017 at 09:28:01AM +0100, Hendrik Brueckner escreveu:
> > Change the Makefile and build process to no longer require auditlibs
> > interfaces when the architecture provides system call tables.
> 
> And this one will have to wait for the fix in how the errno translation
> tables are generated, ok?

Yes, it has to wait.

Regards,
  Hendrik
