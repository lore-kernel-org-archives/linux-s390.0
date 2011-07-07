From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch 1/1] [PATCH] include storage keys in
	hibernation image.
Date: Thu, 7 Jul 2011 23:36:25 +0200
Message-ID: <201107072336.26151.rjw__9520.88415292582$1310074565$gmane$org@sisk.pl>
References: <20110608074523.211912903@de.ibm.com>
	<201106142250.15041.rjw@sisk.pl> <20110615093629.07f01779@mschwide>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110615093629.07f01779@mschwide>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/linux-pm/>
List-Post: <mailto:linux-pm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Jiri Slaby <jslaby@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

On Wednesday, June 15, 2011, Martin Schwidefsky wrote:
> On Tue, 14 Jun 2011 22:50:14 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
...
> 
> Well before the preallocation kicked in we don't know which are the relevant
> storage keys. The only other option would be to store all of them which I
> consider to be a inferior solution. 

I've been thinking about that recently a bit.

Don't we need to restore the keys of the page frames that aren't copied
into the image too?

Rafael
