From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf s390: always build with -fPIC
Date: Fri, 1 Dec 2017 15:12:45 +0100
Message-ID: <20171201141245.GD6452@linux.vnet.ibm.com>
References: <1512031765-9382-1-git-send-email-brueckner@linux.vnet.ibm.com>
 <20171201021709.GB30867@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171201021709.GB30867@sejong>
Sender: linux-perf-users-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-perf-users/>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Linux perf users list <linux-perf-users@vger.kernel.org>, Linux s390 list <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Richter <tmricht@linux.vnet.ibm.com>, jonathan.hermann@de.ibm.com, kernel-team@lge.com, jolsa@kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Namhyung,

On Fri, Dec 01, 2017 at 11:17:09AM +0900, Namhyung Kim wrote:
> On Thu, Nov 30, 2017 at 09:49:25AM +0100, Hendrik Brueckner wrote:
> > On s390, object files must be compiled with position-indepedent code
> > in order to be incrementally linked or linked to shared libraries.
> > Therefore, add -fPIC to the CFLAGS for s390 to ensure each object
> > file is built properly.
> 
> Could you please tell me what was the actual problem?  I guess this is
> somewhat related to the Jiri's Fedora build fix.

Building, linking of perf did not work (I think it was on a Fedora 27)
resulting in an error message like:

/usr/bin/ld: perf-in.o: `__printf_chk@@GLIBC_2.4' non-PLT reloc for symbol
defined in shared library and accessed from executable (rebuild file with
-fPIC ?)
/usr/bin/ld: final link failed: Bad value

On s390, objects must be compiled with -fPIC when used for shared object
or position-indendepent executables (PIE). In doubt, it is better to
build with -fPIC (there are no performance degration).

Thanks and kind regards,
  Hendrik
