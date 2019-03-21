Return-Path: <SRS0=0cHI=RY=vger.kernel.org=linux-fsdevel-owner@kernel.org>
Subject: [RFC PATCH 0/8] Convert mount_single-using filesystems to fs_context
From: David Howells <dhowells@redhat.com>
Date: Thu, 21 Mar 2019 11:47:32 +0000
Message-ID: <155316885201.29437.3428987891437242750.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-fsdevel/>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
To: viro@zeniv.linux.org.uk
Cc: Colin Cross <ccross@android.com>, Steven Rostedt <rostedt@goodmis.org>, Tony Luck <tony.luck@intel.com>, Jeremy Kerr <jk@ozlabs.org>, Kees Cook <keescook@chromium.org>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Anton Vorontsov <anton@enomsg.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com
List-ID: <linux-s390.vger.kernel.org>


Hi Al,

Here's a set of patches that converts the mount_single()-using filesystems
to use the new fs_context struct.  There may be prerequisite commits in the
branch detailed below.

 (1) Add a new keying to vfs_get_super() that indicates that
     ->reconfigure() should be called instead of (*fill_super)() if the
     superblock already exists.

 (2) Convert debugfs.

 (3) Convert tracefs.

 (4) Convert pstore.

 (5) Fix a bug in hypfs.

 (6) Convert hypfs.

 (7) Convert spufs.

 (8) Kill off mount_single().

These can be found in the following branch:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=mount-api-viro

Thanks,
David
---
David Howells (8):
      vfs: Add a single-or-reconfig keying to vfs_get_super()
      vfs: Convert debugfs to fs_context
      vfs: Convert tracefs to fs_context
      vfs: Convert pstore to fs_context
      hypfs: Fix error number left in struct pointer member
      vfs: Convert hypfs to fs_context
      vfs: Convert spufs to fs_context
      vfs: Kill off mount_single()


 Documentation/filesystems/vfs.txt         |    4 -
 arch/powerpc/platforms/cell/spufs/inode.c |  207 ++++++++++++++++-------------
 arch/s390/hypfs/inode.c                   |  137 +++++++++++--------
 fs/debugfs/inode.c                        |  186 ++++++++++++--------------
 fs/pstore/inode.c                         |  110 ++++++++++-----
 fs/super.c                                |   73 ++--------
 fs/tracefs/inode.c                        |  180 ++++++++++++-------------
 include/linux/fs.h                        |    3 
 include/linux/fs_context.h                |    1 
 9 files changed, 446 insertions(+), 455 deletions(-)
